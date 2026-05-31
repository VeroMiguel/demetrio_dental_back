const express = require('express');
const router = express.Router();
const { autenticar } = require('../middleware/auth');
const { Orden, Doctor, Servicio, TokenFCM } = require('../models');
const admin = require('../config/firebase-admin');
const { Op } = require('sequelize');

// Registrar token FCM - VERSIÓN DEFINITIVA
router.post('/registrar-token', autenticar, async (req, res) => {
    try {
        const { token, dispositivo, plataforma } = req.body;
        
        if (!token) {
            return res.status(400).json({ error: 'Token no proporcionado' });
        }
        
        const userAgent = dispositivo || req.headers['user-agent'] || '';
        
        console.log(`📝 [DEBUG] Registrando token para usuario ${req.usuario.id}`);
        
        // ✅ BUSCAR por usuario Y plataforma (no solo por token)
        // Esto evita crear múltiples registros para el mismo usuario/dispositivo
        let tokenRecord = await TokenFCM.findOne({ 
            where: { 
                usuario_id: req.usuario.id,
                plataforma: plataforma || 'web'
            } 
        });
        
        if (tokenRecord) {
            // ✅ Actualizar token existente
            await tokenRecord.update({
                token: token,
                dispositivo: userAgent,
                ultimo_uso: new Date(),
                activo: true,
                actualizado_en: new Date()
            });
            console.log(`✅ Token ACTUALIZADO para usuario ${req.usuario.id} (${plataforma})`);
        } else {
            // ✅ Crear nuevo token (solo si no existe para esta plataforma)
            tokenRecord = await TokenFCM.create({
                token: token,
                usuario_id: req.usuario.id,
                dispositivo: userAgent,
                plataforma: plataforma || 'web',
                ultimo_uso: new Date(),
                activo: true,
                creado_en: new Date(),
                actualizado_en: new Date()
            });
            console.log(`✅ Nuevo token CREADO para usuario ${req.usuario.id} (${plataforma})`);
        }
        
        // ✅ Verificar resultado
        console.log(`📊 Token activo: ${tokenRecord.activo === 1 ? 'SÍ ✅' : 'NO ❌'}`);
        
        res.json({ 
            success: true, 
            message: 'Token registrado correctamente',
            activo: tokenRecord.activo === 1
        });
        
    } catch (error) {
        console.error('❌ Error registrando token:', error);
        res.status(500).json({ error: 'Error registrando token', details: error.message });
    }
});

// Eliminar token FCM (logout)
router.delete('/eliminar-token', autenticar, async (req, res) => {
    try {
        const { token } = req.body;
        await TokenFCM.destroy({ where: { token } });
        console.log(`🗑️ Token FCM eliminado`);
        res.json({ success: true, message: 'Token eliminado' });
    } catch (error) {
        console.error('Error eliminando token:', error);
        res.status(500).json({ error: 'Error eliminando token' });
    }
});

// Enviar prueba de notificación push
router.post('/test', autenticar, async (req, res) => {
    try {
        const tokens = await TokenFCM.findAll({
            where: { usuario_id: req.usuario.id, activo: true }
        });
        
        if (tokens.length === 0) {
            return res.json({ success: false, message: 'No hay tokens FCM registrados' });
        }
        
        for (const tokenRecord of tokens) {
            const message = {
                token: tokenRecord.token,
                notification: {
                    title: '🔔 Notificación de prueba',
                    body: 'Esta es una notificación push desde el servidor',
                    icon: '/favicon.ico'
                },
                data: { url: '/dashboard' }
            };
            await admin.messaging().send(message);
        }
        
        res.json({ success: true, message: 'Notificación de prueba enviada' });
    } catch (error) {
        console.error('Error enviando notificación de prueba:', error);
        res.status(500).json({ error: 'Error enviando notificación' });
    }
});

// Programar notificación push para una orden
router.post('/programar', autenticar, async (req, res) => {
    try {
        const { ordenId, minutosAntes } = req.body;
        
        console.log(`📨 [DEBUG] Solicitud programar push: ordenId=${ordenId}, minutosAntes=${minutosAntes}`);
        
        const orden = await Orden.findByPk(ordenId, {
            include: [
                { model: Doctor, as: 'doctor', attributes: ['nombre'] },
                { model: Servicio, as: 'servicio', attributes: ['nombre'] }
            ]
        });
        
        if (!orden) {
            console.log(`❌ Orden no encontrada: ${ordenId}`);
            return res.status(404).json({ error: 'Orden no encontrada' });
        }
        
        console.log(`📦 Orden encontrada: ${orden.id_externo}, fecha_limite: ${orden.fecha_limite}, hora_limite: ${orden.hora_limite}`);
        
        const fechaHora = new Date(`${orden.fecha_limite}T${orden.hora_limite || '08:00'}`);
        const fechaDisparo = new Date(fechaHora.getTime() - minutosAntes * 60000);
        const ahora = new Date();
        const delay = fechaDisparo.getTime() - ahora.getTime();
        
        console.log(`⏰ Calculando delay: ${Math.round(delay / 60000)} min`);
        
        if (delay > 0) {
            setTimeout(async () => {
                console.log(`🔔 [TIMER] Enviando notificación push para orden ${orden.id_externo} (${minutosAntes} min antes)`);
                
                try {
                    const tokens = await TokenFCM.findAll({
                        where: { usuario_id: orden.usuario_creo_id, activo: true }
                    });
                    
                    if (tokens.length === 0) {
                        console.log(`⚠️ No hay tokens FCM para usuario ${orden.usuario_creo_id}`);
                        return;
                    }
                    
                    for (const tokenRecord of tokens) {
                        const doctorNombre = orden.doctor?.nombre || 'Doctor';
                        const servicioNombre = orden.servicio?.nombre || 'Servicio';
                        const clienteNombre = orden.cliente_nombre || 'Sin cliente';
                        
                        let tituloDetallado, cuerpoDetallado;
                        if (minutosAntes === 0) {
                            tituloDetallado = `📋 ORDEN VENCE AHORA`;
                            cuerpoDetallado = `${orden.id_externo}\n👨‍⚕️ ${doctorNombre}\n🦷 ${servicioNombre}\n👤 ${clienteNombre}`;
                        } else {
                            tituloDetallado = `⚠️ ORDEN POR VENCER`;
                            cuerpoDetallado = `${orden.id_externo}\n⏰ ${minutosAntes} min\n👨‍⚕️ ${doctorNombre}\n🦷 ${servicioNombre}\n👤 ${clienteNombre}`;
                        }
                        
                        const message = {
                            token: tokenRecord.token,
                            notification: {
                                title: tituloDetallado,
                                body: cuerpoDetallado,
                            },
                            android: {
                                priority: 'high',
                                notification: {
                                    title: tituloDetallado,
                                    body: cuerpoDetallado,
                                    icon: 'ic_notification',
                                    color: '#6366f1',
                                    sound: 'default',
                                    channelId: 'ordenes_channel'
                                }
                            },
                            data: {
                                ordenId: orden.id.toString(),
                                url: `/ordenes/${orden.id}`
                            }
                        };
                        
                        try {
                            const response = await admin.messaging().send(message);
                            console.log(`✅ Notificación push enviada: ${response.messageId || 'OK'}`);
                        } catch (sendError) {
                            console.error(`❌ Error enviando push:`, sendError.message);
                            // ✅ SOLO desactivar si el token ya no existe en FCM
                            if (sendError.code === 'messaging/registration-token-not-registered') {
                                await tokenRecord.update({ activo: false });
                                console.log(`⚠️ Token inválido desactivado`);
                            }
                        }
                    }
                } catch (error) {
                    console.error(`❌ Error en envío:`, error);
                }
            }, delay);
            
            res.json({ success: true, message: `Notificación programada para ${minutosAntes} min antes` });
        } else {
            res.json({ success: false, message: 'Fecha ya pasada' });
        }
    } catch (error) {
        console.error('❌ Error:', error);
        res.status(500).json({ error: 'Error programando notificación' });
    }
});

module.exports = router;