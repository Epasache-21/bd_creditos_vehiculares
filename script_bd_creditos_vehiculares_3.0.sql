CREATE DATABASE bd_creditos_vehiculares_2;
GO

USE bd_creditos_vehiculares_2;
GO

--- Creación de Tablas

USE bd_creditos_vehiculares_2;
GO

-- Tabla cliente
CREATE TABLE cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla entidad_financiera
CREATE TABLE entidad_financiera (
    id_entidadFinanciera INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

-- Tabla cuenta
CREATE TABLE cuenta (
    id_cuenta INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    id_entidadFinanciera INT,
    numero_cuenta VARCHAR(50),
    tipo VARCHAR(50),
    saldo DECIMAL(18,2)
);

-- Tabla producto
CREATE TABLE producto (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    descripcion VARCHAR(200),
    precio DECIMAL(18,2)
);

-- Tabla concesionario
CREATE TABLE concesionario (
    id_concesionario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

-- Tabla sucursal
CREATE TABLE sucursal (
    id_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    id_concesionario INT,
    nombre VARCHAR(100),
    direccion VARCHAR(200)
);

-- Tabla producto_sucursal (relación N:M)
CREATE TABLE producto_sucursal (
    id_producto INT,
    id_sucursal INT,
    stock INT,
    PRIMARY KEY (id_producto, id_sucursal)
);

-- Tabla credito
CREATE TABLE credito (
    id_credito INT IDENTITY(1,1) PRIMARY KEY,
    id_cuenta INT,
    id_producto INT,
    monto DECIMAL(18,2),
    interes DECIMAL(5,2),
    fecha_inicio DATE,
    fecha_vencimiento DATE
);

-- Tabla garantia
CREATE TABLE garantia (
    id_garantia INT IDENTITY(1,1) PRIMARY KEY,
    tipo VARCHAR(100),
    descripcion VARCHAR(200),
    valor DECIMAL(18,2)
);

-- Tabla garantia_credito (relación N:M)
CREATE TABLE garantia_credito (
    id_credito INT,
    id_garantia INT,
    PRIMARY KEY (id_credito, id_garantia)
);

-- FK en cuenta
ALTER TABLE cuenta
ADD CONSTRAINT fk_cuenta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    CONSTRAINT fk_cuenta_entidad FOREIGN KEY (id_entidadFinanciera) REFERENCES entidad_financiera(id_entidadFinanciera);

-- FK en sucursal
ALTER TABLE sucursal
ADD CONSTRAINT fk_sucursal_concesionario FOREIGN KEY (id_concesionario) REFERENCES concesionario(id_concesionario);

-- FK en producto_sucursal
ALTER TABLE producto_sucursal
ADD CONSTRAINT fk_productoSucursal_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_productoSucursal_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal);

-- FK en credito
ALTER TABLE credito
ADD CONSTRAINT fk_credito_cuenta FOREIGN KEY (id_cuenta) REFERENCES cuenta(id_cuenta),
    CONSTRAINT fk_credito_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto);

-- FK en garantia_credito
ALTER TABLE garantia_credito
ADD CONSTRAINT fk_garantiaCredito_credito FOREIGN KEY (id_credito) REFERENCES credito(id_credito),
    CONSTRAINT fk_garantiaCredito_garantia FOREIGN KEY (id_garantia) REFERENCES garantia(id_garantia);
