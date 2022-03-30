-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-03-2022 a las 17:20:11
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `examenparcial2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_bio` (IN `_bio` VARCHAR(200), IN `_id` INT)  BEGIN
UPDATE usuarios SET bio = _bio WHERE id = _id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_password` (IN `_pass` VARCHAR(100), IN `_id` INT, IN `_key` VARCHAR(200))  BEGIN
UPDATE usuarios SET pass = aes_encrypt(_pass, _key) WHERE id = _id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_username_exists` (IN `_username` VARCHAR(100), IN `_key` VARCHAR(100))  BEGIN
SELECT id, username, cast(aes_decrypt(pass, _key) AS CHAR ), bio
FROM usuarios
WHERE username = _username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `_username` VARCHAR(100))  BEGIN
	DELETE FROM usuarios WHERE username=_username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register` (IN `_username` VARCHAR(100), IN `_pass` VARCHAR(100), IN `_key` VARCHAR(200))  NO SQL
BEGIN
    INSERT INTO usuarios (username, pass) VALUES (_username, 		aes_encrypt(_pass, _key));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_existence` (IN `_username` VARCHAR(100))  BEGIN
SELECT username FROM usuarios WHERE username = _username;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `pass` blob NOT NULL,
  `bio` varchar(200) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `pass`, `bio`) VALUES
(NULL, 'mvp', 0xc5aa6c758dafcf66720bc8257abc5a52, ''),
(NULL, 'alfredo', 0xc5aa6c758dafcf66720bc8257abc5a52, '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
