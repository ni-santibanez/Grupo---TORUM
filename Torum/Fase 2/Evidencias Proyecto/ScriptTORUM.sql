-- Tabla Vertical
CREATE TABLE Vertical (
    idVertical INTEGER PRIMARY KEY,
    nameVert VARCHAR2(32)
);

-- Tabla Negocio
CREATE TABLE Negocio (
    idNegocio INTEGER PRIMARY KEY,
    nombre VARCHAR2(50),
    logo VARCHAR2(32),
    direccion VARCHAR2(100),
    telefono VARCHAR2(20),
    Vertical_idVertical INTEGER,
    CONSTRAINT Negocio_Vertical_FK FOREIGN KEY (Vertical_idVertical) REFERENCES Vertical(idVertical)
);

-- Tabla Comuna
CREATE TABLE Comuna (
    idComuna INTEGER PRIMARY KEY,
    nomComuna VARCHAR2(30),
    Region_idRegion INTEGER,
    CONSTRAINT Comuna_Region_FK FOREIGN KEY (Region_idRegion) REFERENCES Region(idRegion)
);

-- Tabla Region
CREATE TABLE Region (
    idRegion INTEGER PRIMARY KEY,
    nomRegion VARCHAR2(20)
);

-- Tabla Sitio
CREATE TABLE Sitio (
    idSitio INTEGER PRIMARY KEY,
    region VARCHAR2(15),
    comuna VARCHAR2(15),
    direccion VARCHAR2(25),
    telefono INTEGER,
    descripcion VARCHAR2(50),
    latitud FLOAT,
    longitud FLOAT,
    plano BLOB,
    Negocio_idNegocio INTEGER,
    Comuna_idComuna INTEGER,
    CONSTRAINT Sitio_Negocio_FK FOREIGN KEY (Negocio_idNegocio) REFERENCES Negocio(idNegocio),
    CONSTRAINT Sitio_Comuna_FK FOREIGN KEY (Comuna_idComuna) REFERENCES Comuna(idComuna)
);

-- Tabla Protocolo
CREATE TABLE Protocolo (
    idProtocolo INTEGER PRIMARY KEY,
    nomProtocolo VARCHAR2(30)
);

-- Tabla ConfModbus
CREATE TABLE ConfModbus (
    idModbus INTEGER PRIMARY KEY,
    tipoProtocolo VARCHAR2(15),
    direccionMaestro INTEGER,
    puertoSerial VARCHAR2(14),
    baudrate VARCHAR2(14),
    paridad VARCHAR2(14)
);

-- Tabla Equipo
CREATE TABLE Equipo (
    idEquipo INTEGER PRIMARY KEY,
    nomEquipo VARCHAR2(20),
    IP VARCHAR2(15),
    mascaraSubred VARCHAR2(20),
    gateway VARCHAR2(25),
    puerto VARCHAR2(5),
    Sitio_idSitio INTEGER,
    ConfModbus_idModbus INTEGER,
    Protocolo_idProtocolo INTEGER,
    CONSTRAINT Equipo_Sitio_FK FOREIGN KEY (Sitio_idSitio) REFERENCES Sitio(idSitio),
    CONSTRAINT Equipo_ConfModbus_FK FOREIGN KEY (ConfModbus_idModbus) REFERENCES ConfModbus(idModbus),
    CONSTRAINT Equipo_Protocolo_FK FOREIGN KEY (Protocolo_idProtocolo) REFERENCES Protocolo(idProtocolo)
);

-- Tabla Dispositivo
CREATE TABLE Dispositivo (
    idDispositivo INTEGER PRIMARY KEY,
    direccionEsclavo VARCHAR2(15),
    direccionRegistro VARCHAR2(15),
    ConfModbus_idModbus INTEGER,
    CONSTRAINT Dispositivo_ConfModbus_FK FOREIGN KEY (ConfModbus_idModbus) REFERENCES ConfModbus(idModbus)
);

-- Tabla tipoRegistro
CREATE TABLE tipoRegistro (
    idTipoRegistro INTEGER PRIMARY KEY,
    tipoRegistro VARCHAR2(15),
    nomTipoRegistro VARCHAR2(20)
);

-- Tabla Unidad
CREATE TABLE Unidad (
    idUnidad INTEGER PRIMARY KEY,
    nombreUnidad VARCHAR2(30)
);

-- Tabla Registro
CREATE TABLE Registro (
    idRegistro INTEGER PRIMARY KEY,
    tipoRegistro VARCHAR2(32),
    direccionRegistro INTEGER,
    cantidadRegistros INTEGER,
    Dispositivo_idDispositivo INTEGER,
    tipoRegistro_idTipoRegistro INTEGER,
    Unidad_idUnidad INTEGER,
    CONSTRAINT Registro_Dispositivo_FK FOREIGN KEY (Dispositivo_idDispositivo) REFERENCES Dispositivo(idDispositivo),
    CONSTRAINT Registro_tipoRegistro_FK FOREIGN KEY (tipoRegistro_idTipoRegistro) REFERENCES tipoRegistro(idTipoRegistro),
    CONSTRAINT Registro_Unidad_FK FOREIGN KEY (Unidad_idUnidad) REFERENCES Unidad(idUnidad)
);

-- Tabla tipoMedicion
CREATE TABLE tipoMedicion (
    idTipoMedicion INTEGER PRIMARY KEY,
    nomTipoMedicion VARCHAR2(30)
);

-- Tabla Medicion
CREATE TABLE Medicion (
    idMedicion INTEGER PRIMARY KEY,
    tipoMedicion VARCHAR2(32),
    valor FLOAT,
    timestamp DATE,
    Registro_idRegistro INTEGER,
    tipoMedicion_idTipoMedicion INTEGER,
    CONSTRAINT Medicion_Registro_FK FOREIGN KEY (Registro_idRegistro) REFERENCES Registro(idRegistro),
    CONSTRAINT Medicion_tipoMedicion_FK FOREIGN KEY (tipoMedicion_idTipoMedicion) REFERENCES tipoMedicion(idTipoMedicion)
);

-- Tabla mediciones_historicas
CREATE TABLE mediciones_historicas (
    idMedHist INTEGER PRIMARY KEY,
    fecha DATE,
    valor INTEGER,
    Medicion_idMedicion INTEGER,
    CONSTRAINT mediciones_historicas_Medicion_FK FOREIGN KEY (Medicion_idMedicion) REFERENCES Medicion(idMedicion)
);

-- Tabla Cliente
CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY,
    usuario VARCHAR2(15),
    contraseña VARCHAR2(15),
    mail VARCHAR2(32),
    Negocio_idNegocio INTEGER,
    CONSTRAINT Cliente_Negocio_FK FOREIGN KEY (Negocio_idNegocio) REFERENCES Negocio(idNegocio)
);
