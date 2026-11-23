/* ============================================================
   Parcial #3 - Ejercicio 3: Login con BCrypt (Adaptado a MySQL)
   ============================================================ */

-- 1. Creación de la base de datos con soporte completo para caracteres especiales y emojis (utf8mb4)
CREATE DATABASE IF NOT EXISTS LoginBCrypt
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE LoginBCrypt;

-- 2. Tabla de usuarios: la contraseña NUNCA se guarda en texto plano,
-- solo el hash generado con BCrypt (60 caracteres, incluye la sal).
CREATE TABLE IF NOT EXISTS Usuarios
(
    Id              INT AUTO_INCREMENT PRIMARY KEY,
    NombreUsuario   VARCHAR(50)  NOT NULL UNIQUE,
    NombreCompleto  VARCHAR(100) NOT NULL,
    PasswordHash    VARCHAR(100) NOT NULL,
    FechaCreacion   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tabla de intentos de acceso (fallidos y exitosos) para análisis posterior.
CREATE TABLE IF NOT EXISTS IntentosLogin
(
    Id              INT AUTO_INCREMENT PRIMARY KEY,
    NombreUsuario   VARCHAR(50)  NOT NULL,
    Exitoso         TINYINT(1)   NOT NULL, -- Equivalente estándar a booleano (1 = true, 0 = false)
    Fecha           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

/* ------------------------------------------------------------
   Consultas útiles para el análisis de intentos
   ------------------------------------------------------------ */
-- Historial completo
-- SELECT * FROM IntentosLogin ORDER BY Fecha DESC;

-- Resumen por usuario
-- SELECT NombreUsuario,
--        SUM(CASE WHEN Exitoso = 1 THEN 1 ELSE 0 END) AS Exitosos,
--        SUM(CASE WHEN Exitoso = 0 THEN 1 ELSE 0 END) AS Fallidos
-- FROM IntentosLogin
-- GROUP BY NombreUsuario;

/* ------------------------------------------------------------
   Backup de la base de datos (para subir al repositorio).
   En MySQL no se hace mediante una sentencia SQL dentro del script,
   sino ejecutando la herramienta 'mysqldump' en la terminal/consola
   o usando la opción "Data Export" en MySQL Workbench:
   
   Comando de ejemplo en terminal (CMD / PowerShell / Bash):
   mysqldump -u root -p LoginBCrypt > C:\Backups\LoginBCrypt.sql
   ------------------------------------------------------------ */