
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
SET SESSION wait_timeout = 600;
SET SESSION interactive_timeout = 600;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `labtrack_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuraciones`
--

CREATE TABLE `configuraciones` (
  `id` int NOT NULL,
  `clave` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `valor` text COLLATE utf8mb4_unicode_ci,
  `tipo_dato` enum('texto','numero','booleano','json') COLLATE utf8mb4_unicode_ci DEFAULT 'texto',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `actualizado_en` datetime NOT NULL,
  `creado_en` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuraciones`
--

INSERT INTO `configuraciones` (`id`, `clave`, `valor`, `tipo_dato`, `descripcion`, `actualizado_en`, `creado_en`) VALUES
(1, 'app_nombre', 'LabTrack Pro', 'texto', 'Nombre de la aplicación', '2026-03-09 16:48:09', '2026-03-10 00:51:51'),
(2, 'app_version', '1.0.0', 'texto', 'Versión actual', '2026-03-09 16:48:09', '2026-03-10 00:51:51'),
(3, 'tema_por_defecto', 'dark', 'texto', 'Tema inicial de la interfaz', '2026-03-09 16:48:09', '2026-03-10 00:51:51'),
(4, 'whatsapp_mensaje_base', 'Hola Dr(a). {doctor}, le comparto el estado de cuenta de su trabajo: {servicio}', 'texto', 'Mensaje base para WhatsApp', '2026-03-09 16:48:09', '2026-03-10 00:51:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

CREATE TABLE `doctores` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_whatsapp` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` text COLLATE utf8mb4_unicode_ci,
  `direccion` text COLLATE utf8mb4_unicode_ci,
  `activo` tinyint(1) DEFAULT '1',
  `creado_en` datetime NOT NULL,
  `actualizado_en` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`id`, `nombre`, `telefono_whatsapp`, `logo_url`, `direccion`, `activo`, `creado_en`, `actualizado_en`) VALUES
(9, 'Dra. Grecia', '961 031 379', '/uploads/doctores/1779758933134.avif', 'Manantay ', 1, '2026-03-28 23:16:42', '2026-05-25 20:28:53'),
(10, 'Dr Herick ', '921 135 421', '/uploads/doctores/1779758857718.jpg', 'Unión con alamedas', 1, '2026-03-28 23:38:34', '2026-05-25 20:27:37'),
(12, 'Dra.MARGOTH ', '+51 947 382 865', '/uploads/doctores/1779758940419.jpg', '', 1, '2026-05-21 19:45:13', '2026-05-25 20:29:00'),
(13, 'Dr.NEGRITO ', '51966187634', '/uploads/doctores/1779758924320.webp', '', 1, '2026-05-21 20:09:03', '2026-05-25 20:28:44'),
(14, 'Dra kandy ', '+51902785485', NULL, 'La tupac', 1, '2026-05-21 20:36:36', '2026-05-21 20:36:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_actividad`
--

CREATE TABLE `logs_actividad` (
  `id` int NOT NULL,
  `usuario_id` int DEFAULT NULL,
  `accion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entidad_tipo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entidad_id` int DEFAULT NULL,
  `detalle` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ip_direccion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_en` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_actividad`
--

INSERT INTO `logs_actividad` (`id`, `usuario_id`, `accion`, `entidad_tipo`, `entidad_id`, `detalle`, `ip_direccion`, `creado_en`) VALUES
(43, 2, 'registrar_pago', 'pago', 56, '{\"orden_id\":49,\"monto\":400,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:01:29'),
(44, 2, 'registrar_pago', 'pago', 57, '{\"orden_id\":49,\"monto\":100,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:02:35'),
(45, 2, 'registrar_pago', 'pago', 58, '{\"orden_id\":49,\"monto\":100,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:02:53'),
(46, 2, 'registrar_pago', 'pago', 59, '{\"orden_id\":49,\"monto\":100,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:03:11'),
(47, 2, 'registrar_pago', 'pago', 60, '{\"orden_id\":49,\"monto\":100,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:03:33'),
(48, 2, 'registrar_pago', 'pago', 61, '{\"orden_id\":49,\"monto\":100,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 01:03:44'),
(49, 2, 'registrar_pago', 'pago', 63, '{\"orden_id\":53,\"monto\":50,\"metodo\":\"efectivo\"}', NULL, '2026-05-22 04:53:03'),
(50, 2, 'registrar_pago', 'pago', 5, '{\"orden_id\":95,\"monto\":40,\"metodo\":\"efectivo\"}', '38.250.159.57', '2026-05-28 06:11:52'),
(51, 2, 'eliminar_pago', 'pago', 1, '{\"orden_id\":92}', '179.7.102.72', '2026-05-29 03:04:18'),
(52, 2, 'registrar_pago', 'pago', 6, '{\"orden_id\":92,\"monto\":68,\"metodo\":\"efectivo\"}', '179.7.102.72', '2026-05-29 03:04:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ordenes`
--

CREATE TABLE `ordenes` (
  `id` int NOT NULL,
  `id_externo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `doctor_id` int NOT NULL,
  `servicio_id` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','terminado') COLLATE utf8mb4_unicode_ci DEFAULT 'pendiente',
  `prioridad` enum('normal','urgente','emergencia') COLLATE utf8mb4_unicode_ci DEFAULT 'normal',
  `fecha_registro` datetime DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `fecha_limite` date DEFAULT NULL,
  `hora_limite` time DEFAULT NULL,
  `cliente_nombre` text COLLATE utf8mb4_unicode_ci,
  `detalle_cliente` text COLLATE utf8mb4_unicode_ci,
  `imagen_referencia_url` text COLLATE utf8mb4_unicode_ci,
  `actualizado_en` datetime NOT NULL,
  `creado_en` datetime NOT NULL,
  `usuario_creo_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ordenes`
--

INSERT INTO `ordenes` (`id`, `id_externo`, `doctor_id`, `servicio_id`, `total`, `estado`, `prioridad`, `fecha_registro`, `fecha_inicio`, `hora_inicio`, `fecha_limite`, `hora_limite`, `cliente_nombre`, `detalle_cliente`, `imagen_referencia_url`, `actualizado_en`, `creado_en`, `usuario_creo_id`) VALUES
(92, 'ORD-1779909245689', 10, 52, 68.00, 'terminado', 'normal', '2026-05-27 14:14:05', NULL, NULL, '2026-05-27', '14:20:00', 'Mario', 'Limpieza', NULL, '2026-05-28 22:04:30', '2026-05-27 14:14:05', 2),
(93, 'ORD-1779912045493', 13, 52, 20.00, 'pendiente', 'normal', '2026-05-27 15:00:45', NULL, NULL, '2026-05-27', '15:08:00', 'maria', 'limpieza', NULL, '2026-05-27 15:00:45', '2026-05-27 15:00:45', 2),
(95, 'ORD-1779926972133', 9, 59, 80.00, 'terminado', 'normal', '2026-05-27 19:09:32', NULL, NULL, '2026-05-27', '19:17:00', 'Miguel', 'Limpieza', NULL, '2026-05-28 01:11:52', '2026-05-27 19:09:32', 2),
(99, 'ORD-1780027449210', 9, 52, 60.00, 'pendiente', 'normal', '2026-05-28 23:04:09', NULL, NULL, '2026-05-28', '23:09:00', 'Jose', NULL, NULL, '2026-05-28 23:04:09', '2026-05-28 23:04:09', 2),
(100, 'ORD-1780027929981', 12, 48, 68.00, 'pendiente', 'normal', '2026-05-28 23:12:09', NULL, NULL, '2026-05-28', '23:17:00', 'Jose', NULL, NULL, '2026-05-28 23:12:09', '2026-05-28 23:12:09', 2),
(101, 'ORD-1780030101754', 10, 55, 50.00, 'pendiente', 'normal', '2026-05-28 23:48:21', NULL, NULL, '2026-05-28', '23:52:00', 'María', NULL, NULL, '2026-05-28 23:48:21', '2026-05-28 23:48:21', 2),
(102, 'ORD-1780030447179', 9, 47, 80.00, 'pendiente', 'normal', '2026-05-28 23:54:07', NULL, NULL, '2026-05-28', '23:59:00', 'Paolo', NULL, NULL, '2026-05-28 23:54:07', '2026-05-28 23:54:07', 2),
(103, 'ORD-1780076302602', 10, 55, 555.00, 'pendiente', 'normal', '2026-05-29 12:38:22', NULL, NULL, '2026-05-28', '12:44:00', NULL, NULL, '/uploads/ordenes/1780076302600.jpg', '2026-05-29 12:43:41', '2026-05-29 12:38:22', 2),
(104, 'ORD-1780078569274', 9, 52, 50.00, 'pendiente', 'normal', '2026-05-29 13:16:09', NULL, NULL, '2026-05-30', '13:15:00', 'Jose', 'Limpieza dental', '/uploads/ordenes/1780078569273.png', '2026-05-29 13:16:09', '2026-05-29 13:16:09', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int NOT NULL,
  `orden_id` int NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo_pago` enum('efectivo','tarjeta','transferencia','yape','plin','deposito') COLLATE utf8mb4_unicode_ci DEFAULT 'efectivo',
  `observaciones` text COLLATE utf8mb4_unicode_ci,
  `usuario_registro_id` int DEFAULT NULL,
  `referencia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `creado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `orden_id`, `monto`, `metodo_pago`, `observaciones`, `usuario_registro_id`, `referencia`, `creado_en`, `actualizado_en`) VALUES
(4, 95, 40.00, 'efectivo', NULL, 2, NULL, '2026-05-28 00:38:17', '2026-05-28 00:38:17'),
(5, 95, 40.00, 'efectivo', NULL, 2, 'completo', '2026-05-28 01:11:52', '2026-05-28 01:11:52'),
(6, 92, 68.00, 'efectivo', NULL, 2, 'Completo', '2026-05-28 22:04:30', '2026-05-28 22:04:30'),
(7, 104, 10.00, 'efectivo', NULL, 2, NULL, '2026-05-29 13:16:09', '2026-05-29 13:16:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio_referencial` decimal(10,2) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `creado_en` datetime NOT NULL,
  `actualizado_en` datetime NOT NULL,
  `imagen_url` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `precio_referencial`, `activo`, `creado_en`, `actualizado_en`, `imagen_url`) VALUES
(21, 'Ivocron', 540.00, 1, '2026-03-28 23:20:50', '2026-03-28 23:25:07', '/uploads/servicios/1774758050742.jpg'),
(23, 'Bace metálica  terminado', 400.00, 1, '2026-03-30 16:15:25', '2026-04-06 02:34:55', '/uploads/servicios/1775460895074.jpg'),
(25, 'Total sup-inf', 400.00, 1, '2026-03-30 20:13:25', '2026-04-05 01:46:41', '/uploads/servicios/1775371601158.jpg'),
(28, 'PROTESIS TOTAL CON MALLA', 250.00, 1, '2026-04-04 21:16:12', '2026-04-06 02:30:39', '/uploads/servicios/1775460639645.jpg'),
(29, 'PROTESIS TOTAL + TRIPLEX', 400.00, 1, '2026-04-04 21:17:00', '2026-04-06 02:30:21', '/uploads/servicios/1775460621565.jpg'),
(30, 'PROTESIS PARCIAL CON WIPLA', 180.00, 1, '2026-04-04 21:17:45', '2026-04-06 02:30:04', '/uploads/servicios/1775460604081.jpeg'),
(31, 'PROTESIS FLEXIBLE', 400.00, 1, '2026-04-04 21:18:27', '2026-04-06 02:28:52', '/uploads/servicios/1775460532532.jpg'),
(32, 'PROTESIS HIBRIDA', 500.00, 1, '2026-04-04 21:19:18', '2026-04-06 02:32:09', '/uploads/servicios/1775460729568.webp'),
(33, 'PLACA DE CONTENCION HAWLEY', 150.00, 1, '2026-04-04 21:21:21', '2026-04-06 02:28:27', '/uploads/servicios/1775460507115.png'),
(34, 'PERNOS DIRECTOS DE ACRÍLICO', 50.00, 1, '2026-04-04 21:22:06', '2026-04-06 02:27:57', '/uploads/servicios/1775460477679.png'),
(35, 'ORTODONCIA HYRAX / JAIRACK', 250.00, 1, '2026-04-04 21:22:52', '2026-04-06 02:27:33', '/uploads/servicios/1775460453659.jpeg'),
(36, 'MANTENEDOR DE ESPACIO', 100.00, 1, '2026-04-04 21:23:46', '2026-04-06 02:26:55', '/uploads/servicios/1775460415472.jpg'),
(37, 'JACKETS DE IVOCRON', 80.00, 1, '2026-04-04 21:24:27', '2026-04-06 02:26:37', '/uploads/servicios/1775460397620.png'),
(38, 'INCRUSTACIONES DE ZIRCONIO', 350.00, 1, '2026-04-04 21:25:13', '2026-04-06 02:26:13', '/uploads/servicios/1775460373493.jpg'),
(39, 'FERULA DE ACRÍLICO', 150.00, 1, '2026-04-04 21:25:52', '2026-04-06 02:25:53', '/uploads/servicios/1775460353682.jpg'),
(40, 'FERULA DE ACETATO EN BACKUN', 50.00, 1, '2026-04-04 21:26:44', '2026-04-06 02:25:33', '/uploads/servicios/1775460333754.jpg'),
(41, 'CUBETA INDIVIDUAL', 10.00, 1, '2026-04-04 21:27:25', '2026-04-06 02:25:16', '/uploads/servicios/1775460316441.jpg'),
(42, 'CORONAS PROVISIONALES TERMO CURABLE', 50.00, 1, '2026-04-04 21:28:07', '2026-04-06 02:25:04', '/uploads/servicios/1775460304008.webp'),
(43, 'CORONAS PROVISIONALES AUTOCURABLE', 30.00, 1, '2026-04-04 21:28:58', '2026-04-06 02:24:40', '/uploads/servicios/1775460280391.jpg'),
(44, 'CORONAS PORCELANA EN VENEER', 130.00, 1, '2026-04-04 21:29:39', '2026-04-06 02:24:19', '/uploads/servicios/1775460259778.jpg'),
(45, 'CORONAS DE ZIRCONIO', 400.00, 1, '2026-04-04 21:30:24', '2026-04-06 02:24:01', '/uploads/servicios/1775460241188.jpg'),
(46, 'CORONAS DE PORCELANA', 110.00, 1, '2026-04-04 21:31:14', '2026-04-06 02:23:36', '/uploads/servicios/1775460216581.jpg'),
(47, 'CORONAS DE METAL', 60.00, 1, '2026-04-04 21:31:53', '2026-04-06 02:23:18', '/uploads/servicios/1775460198474.png'),
(48, 'CORONAS DE IVOCRON', 90.00, 1, '2026-04-04 21:32:44', '2026-04-06 02:23:02', '/uploads/servicios/1775460182578.png'),
(49, 'CORONAS CON HOMBRO CERAMICO', 150.00, 1, '2026-04-04 21:33:28', '2026-04-06 02:22:09', '/uploads/servicios/1775460129549.png'),
(50, 'CORONA DE IMPLANTE', 200.00, 1, '2026-04-04 21:34:06', '2026-05-25 20:31:02', '/uploads/servicios/1779759062894.jpg'),
(51, 'BASE METALICA CON ACRILICO TRIPLEX', 400.00, 1, '2026-04-04 21:35:03', '2026-05-25 20:30:37', '/uploads/servicios/1779759037007.jpg'),
(52, 'ATACHES', 300.00, 1, '2026-04-04 21:35:41', '2026-05-25 20:30:11', '/uploads/servicios/1779759011581.png'),
(55, '1 prótesis acrílica superior', 400.00, 1, '2026-04-06 02:42:28', '2026-04-06 12:10:15', '/uploads/servicios/1775461348695.jpg'),
(57, 'P. DE8PIEZAS DE IVOCRON CON METAL', 820.00, 1, '2026-05-21 20:12:00', '2026-05-21 20:12:00', '/uploads/servicios/1779412320950.jpg'),
(58, '2coronas de Acrilico termo', 100.00, 1, '2026-05-21 20:34:44', '2026-05-21 20:34:44', NULL),
(59, 'Corona', 200.00, 1, '2026-05-21 23:49:16', '2026-05-21 23:49:16', '/uploads/servicios/1779425356977.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens_fcm`
--

CREATE TABLE `tokens_fcm` (
  `id` int NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  `dispositivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plataforma` enum('web','android','ios','windows','mac') COLLATE utf8mb4_unicode_ci DEFAULT 'web',
  `ultimo_uso` datetime DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) DEFAULT '1',
  `creado_en` datetime NOT NULL,
  `actualizado_en` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tokens_fcm`
--

INSERT INTO `tokens_fcm` (`id`, `token`, `usuario_id`, `dispositivo`, `plataforma`, `ultimo_uso`, `activo`, `creado_en`, `actualizado_en`) VALUES
(20, 'fe4MCLjVS5j4ZD_-YNrIC5:APA91bFdpaYNEIjNusBZAibLyDfne7xpKjXjiitn6024iv82SE5KhTN_PewjyCzYnSWzIPJMwHBdBf5XA3yQKqKhBGMhiYjOiEsem74rY2vmIVhqxMnUP9E', 2, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'android', '2026-05-29 16:42:28', 1, '2026-05-27 13:10:05', '2026-05-29 16:42:28'),
(21, 'd3quYRVK7CYYGgKCzdnIe6:APA91bE_YSfp-36sU_NGJE3ANUvIoyDfZGe5yyUZYzmH63SplrzDnvkx7OrQ_asZyCnSBUd3-FU7R0oguUAxcD9GpneK1JSUrcnPDEFecosLpy7R4r0lbxM', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'windows', '2026-05-29 13:16:09', 0, '2026-05-27 14:55:43', '2026-05-29 13:26:07'),
(22, 'f-Fsfl9q2LPDCkfMy-m-Oo:APA91bFdVNRfvbOkLFCKEthcG2ZbVSc5HnGRO_5SP9_Gk8WfuldgXT8LHJcT8aEKIbXaKlNwI9A7xtQ5TeFkxVOx1JRYMNc-K1rrEf1i_W3uzMemN_F-uV4', 2, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'windows', '2026-05-28 23:21:41', 0, '2026-05-28 23:21:41', '2026-05-28 23:48:22'),
(23, 'c0ke8e-idEHYPq6zvM-sN5:APA91bEZsM7NslWSRTqYL2TGxBjxm7qf99W60CYpXduB6j_OsM99dTBHjAuoShk0H7WpVOrMAFo1aLIuMByW-ioBpTIFLEb-ybJ1Khiv3e75B4qpUel6zpM', 2, 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36', 'android', '2026-05-29 12:45:43', 0, '2026-05-29 12:37:39', '2026-05-29 13:16:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `nombre_usuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasena_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_completo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rol` enum('admin','operador','supervisor') COLLATE utf8mb4_unicode_ci DEFAULT 'operador',
  `activo` tinyint(1) DEFAULT '1',
  `ultimo_acceso` datetime DEFAULT NULL,
  `creado_en` datetime NOT NULL,
  `actualizado_en` datetime NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ultimo_ip` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intentos_fallidos` int DEFAULT '0',
  `bloqueado_hasta` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena_hash`, `nombre_completo`, `rol`, `activo`, `ultimo_acceso`, `creado_en`, `actualizado_en`, `email`, `ultimo_ip`, `intentos_fallidos`, `bloqueado_hasta`) VALUES
(2, 'edwardvilla', '$2a$10$suJAvYLFV.raGY2CtspWEe7YguMyBxQiMWEfwpIWoac9LZZQe5ppe', 'Edward Villa', 'admin', 1, '2026-05-29 21:32:53', '0000-00-00 00:00:00', '2026-05-29 21:32:53', 'edward@labtrack.com', '190.43.252.240', 0, NULL);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_dashboard_metricas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_dashboard_metricas` (
`ordenes_activas` bigint
,`deuda_total` decimal(55,2)
,`caja_hoy` decimal(32,2)
,`deuda_pendiente` decimal(55,2)
,`ordenes_terminadas` bigint
,`ordenes_vencidas` bigint
,`caja_semana` decimal(32,2)
,`caja_mes` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vista_resumen_doctores`
--

CREATE TABLE `vista_resumen_doctores` (
  `id` int DEFAULT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono_whatsapp` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `total_ordenes` bigint DEFAULT NULL,
  `ordenes_pendientes` bigint DEFAULT NULL,
  `total_facturado` decimal(32,2) DEFAULT NULL,
  `total_pagado` decimal(54,2) DEFAULT NULL,
  `deuda_total` decimal(55,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vista_ultima_actividad`
--

CREATE TABLE `vista_ultima_actividad` (
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `accion` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `entidad_tipo` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `detalle` longtext COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_dashboard_metricas`
--
DROP TABLE IF EXISTS `vista_dashboard_metricas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vista_dashboard_metricas`  AS SELECT (select count(0) from `ordenes` where (`ordenes`.`estado` = 'pendiente')) AS `ordenes_activas`, (select coalesce(sum((`o`.`total` - coalesce((select sum(`p`.`monto`) from `pagos` `p` where (`p`.`orden_id` = `o`.`id`)),0))),0) from `ordenes` `o`) AS `deuda_total`, (select coalesce(sum(`pagos`.`monto`),0) from `pagos` where (cast(`pagos`.`creado_en` as date) = curdate())) AS `caja_hoy`, (select coalesce(sum((`o`.`total` - coalesce((select sum(`p`.`monto`) from `pagos` `p` where (`p`.`orden_id` = `o`.`id`)),0))),0) from `ordenes` `o` where (`o`.`estado` = 'pendiente')) AS `deuda_pendiente`, (select count(0) from `ordenes` where (`ordenes`.`estado` = 'terminado')) AS `ordenes_terminadas`, (select count(0) from `ordenes` `o` where ((`o`.`estado` = 'pendiente') and (`o`.`fecha_limite` <= curdate()) and ((`o`.`total` - coalesce((select sum(`p`.`monto`) from `pagos` `p` where (`p`.`orden_id` = `o`.`id`)),0)) > 0))) AS `ordenes_vencidas`, (select coalesce(sum(`pagos`.`monto`),0) from `pagos` where (`pagos`.`creado_en` >= (curdate() - interval 7 day))) AS `caja_semana`, (select coalesce(sum(`pagos`.`monto`),0) from `pagos` where ((month(`pagos`.`creado_en`) = month(curdate())) and (year(`pagos`.`creado_en`) = year(curdate())))) AS `caja_mes` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `configuraciones`
--
ALTER TABLE `configuraciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `logs_actividad`
--
ALTER TABLE `logs_actividad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_orden_id` (`orden_id`),
  ADD KEY `idx_usuario_registro_id` (`usuario_registro_id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tokens_fcm`
--
ALTER TABLE `tokens_fcm`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_unique` (`token`(255)),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `configuraciones`
--
ALTER TABLE `configuraciones`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `doctores`
--
ALTER TABLE `doctores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `logs_actividad`
--
ALTER TABLE `logs_actividad`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `ordenes`
--
ALTER TABLE `ordenes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `tokens_fcm`
--
ALTER TABLE `tokens_fcm`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_pagos_orden` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pagos_usuario` FOREIGN KEY (`usuario_registro_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `tokens_fcm`
--
ALTER TABLE `tokens_fcm`
  ADD CONSTRAINT `tokens_fcm_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
