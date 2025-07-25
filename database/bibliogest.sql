-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-07-2025 a las 00:13:04
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bibliogest`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `codigo_libro` varchar(10) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `autor` varchar(100) NOT NULL,
  `editorial` varchar(100) DEFAULT NULL,
  `anio_publicacion` int(11) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `cantidad_total` int(11) DEFAULT 1,
  `cantidad_disponible` int(11) DEFAULT NULL,
  `codigo_isbn` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`codigo_libro`, `titulo`, `autor`, `editorial`, `anio_publicacion`, `categoria`, `cantidad_total`, `cantidad_disponible`, `codigo_isbn`) VALUES
('L001', 'Cien años de soledad', 'Gabriel García Márquez', 'Sudamericana', 1995, 'Literatura clásica', 6, 5, '978-695954523'),
('L002', 'Don Quijote de la Mancha', 'Miguel de Cervantes', 'Sudamericana', 2001, 'Literatura clásica', 8, 7, '978-736333161'),
('L003', 'La sombra del viento', 'Carlos Ruiz Zafón', 'Alfaguara', 1980, 'Novela', 5, 4, '978-695914632'),
('L004', 'Rayuela', 'Julio Cortázar', 'Seix Barral', 1991, 'Literatura clásica', 10, 9, '978-467476352'),
('L005', 'Ficciones', 'Jorge Luis Borges', 'Alfaguara', 1957, 'Realismo mágico', 5, 4, '978-943934601'),
('L006', 'El amor en los tiempos del cólera', 'Gabriel García Márquez', 'Planeta', 1954, 'Ficción', 2, 1, '978-732784106'),
('L007', 'Pedro Páramo', 'Juan Rulfo', 'Anagrama', 1995, 'Novela', 6, 6, '978-778223476'),
('L008', 'La ciudad y los perros', 'Mario Vargas Llosa', 'Seix Barral', 2016, 'Drama', 10, 10, '978-340597407'),
('L009', 'Crónica de una muerte anunciada', 'Gabriel García Márquez', 'Alfaguara', 1999, 'Novela', 6, 6, '978-236254145'),
('L010', 'El túnel', 'Ernesto Sabato', 'Santillana', 1994, 'Literatura clásica', 6, 6, '978-242318069'),
('L011', 'Los detectives salvajes', 'Roberto Bolaño', 'Espasa', 1962, 'Literatura clásica', 7, 7, '978-747164506'),
('L012', 'Como agua para chocolate', 'Laura Esquivel', 'Alfaguara', 1962, 'Drama', 10, 10, '978-948003338'),
('L013', 'La casa de los espíritus', 'Isabel Allende', 'Alfaguara', 1976, 'Novela', 8, 8, '978-476224298'),
('L014', 'Marianela', 'Benito Pérez Galdós', 'Planeta', 1968, 'Novela', 10, 10, '978-185284127'),
('L015', 'Doña Bárbara', 'Rómulo Gallegos', 'Alfaguara', 1956, 'Realismo mágico', 6, 6, '978-289017254'),
('L016', 'Aura', 'Carlos Fuentes', 'Debolsillo', 1961, 'Literatura clásica', 6, 6, '978-142550405'),
('L017', 'Santa Evita', 'Tomás Eloy Martínez', 'Debolsillo', 1991, 'Romance', 9, 9, '978-218789686'),
('L018', 'La tregua', 'Mario Benedetti', 'Espasa', 2008, 'Drama', 10, 10, '978-359726066'),
('L019', 'Sobre héroes y tumbas', 'Ernesto Sabato', 'Tusquets', 1981, 'Novela', 10, 10, '978-843925126'),
('L020', 'La fiesta del chivo', 'Mario Vargas Llosa', 'Debolsillo', 1989, 'Drama', 4, 4, '978-655018247');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `codigo_prestamo` varchar(10) NOT NULL,
  `id_usuario_lector` varchar(10) DEFAULT NULL,
  `id_usuario_bibliotecario` varchar(10) DEFAULT NULL,
  `codigo_libro` varchar(10) DEFAULT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion_esperada` date NOT NULL,
  `fecha_devolucion_real` date DEFAULT NULL,
  `estado` varchar(15) DEFAULT NULL CHECK (`estado` in ('activo','devuelto','vencido')),
  `dias_retraso` int(11) DEFAULT NULL,
  `penalizacion` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`codigo_prestamo`, `id_usuario_lector`, `id_usuario_bibliotecario`, `codigo_libro`, `fecha_prestamo`, `fecha_devolucion_esperada`, `fecha_devolucion_real`, `estado`, `dias_retraso`, `penalizacion`) VALUES
('P001', 'U001', 'B001', 'L001', '2025-07-25', '2025-07-26', NULL, 'Activo', 0, 0.00),
('P002', 'U002', 'B001', 'L002', '2025-07-25', '2025-07-27', NULL, 'Activo', 0, 0.00),
('P003', 'U003', 'B001', 'L003', '2025-07-25', '2025-07-28', NULL, 'Activo', 0, 0.00),
('P004', 'U004', 'B001', 'L004', '2025-07-25', '2025-07-29', NULL, 'Activo', 0, 0.00),
('P005', 'U005', 'B001', 'L005', '2025-07-25', '2025-07-29', NULL, 'Activo', 0, 0.00),
('P006', 'U006', 'B001', 'L006', '2025-07-25', '2025-07-30', NULL, 'Activo', 0, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` varchar(10) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL CHECK (`rol` in ('lector','bibliotecario','administrador'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombres`, `apellidos`, `correo`, `contrasena`, `rol`) VALUES
('A001', 'Gerson', 'Barrientos', 'gbarrientos@bibliogest.com', '1234', 'administrador'),
('B001', 'Sebastian', 'Silva', 'ssilva@bibliogest.com', '1234', 'bibliotecario'),
('U001', 'Daniel', 'Carnero', 'dcarnero@bibliogest.com', '1234', 'lector'),
('U002', 'Cesar', 'Cordova', 'ccordova@bibliogest.com', '1234', 'lector'),
('U003', 'Kelly', 'Galeano', 'kgaleano@bibliogest.com', '1234', 'lector'),
('U004', 'Esperanza', 'Bernedo', 'ebernedo@bibliogest.com', '1234', 'lector'),
('U005', 'Carlos', 'Baca', 'cbaca@bibliogest.com', '1234', 'lector'),
('U006', 'Nicolas', 'Zavaleta', 'nzavaleta@bibliogest.com', '1234', 'lector');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`codigo_libro`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`codigo_prestamo`),
  ADD KEY `id_usuario_lector` (`id_usuario_lector`),
  ADD KEY `id_usuario_bibliotecario` (`id_usuario_bibliotecario`),
  ADD KEY `codigo_libro` (`codigo_libro`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_usuario_lector`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`id_usuario_bibliotecario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `prestamo_ibfk_3` FOREIGN KEY (`codigo_libro`) REFERENCES `libro` (`codigo_libro`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
