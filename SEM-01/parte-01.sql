--Elegir una base de datos
USE master
go
--Eliminar una BD existente
--Comentario simple
/*
Comentario multilinea
*/
DROP DATABASE IF EXISTS ServiciosPeruDB
go
--Crear una base de datos
CREATE DATABASE ServiciosPeruDB
go

USE ServiciosPeruDB
go
--Ejecutar script de BD
/*
 * ER/Studio 8.0 SQL Code Generation
 * Company :      devmaster
 * Project :      SQL2017_SEM01_CLASE.DM1
 * Author :       gmanriquev
 *
 * Date Created : Sunday, January 05, 2020 13:06:12
 * Target DBMS : Microsoft SQL Server 2008
 */

/* 
 * TABLE: Asignacion 
 */

CREATE TABLE Asignacion(
    idencuestador    int     NOT NULL,
    idmanzana        int     NOT NULL,
    fecinicio        date    NOT NULL,
    idsupervisor     int     NOT NULL,
    fecfin           date    NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (idencuestador, idmanzana, fecinicio)
)
go



IF OBJECT_ID('Asignacion') IS NOT NULL
    PRINT '<<< CREATED TABLE Asignacion >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Asignacion >>>'
go

/* 
 * TABLE: Cliente 
 */

CREATE TABLE Cliente(
    idcliente      int         IDENTITY(1,1),
    idpersona      int         NOT NULL,
    fecregistro    datetime    NOT NULL,
    estado         bit         NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (idcliente)
)
go



IF OBJECT_ID('Cliente') IS NOT NULL
    PRINT '<<< CREATED TABLE Cliente >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Cliente >>>'
go

/* 
 * TABLE: Encuestador 
 */

CREATE TABLE Encuestador(
    idencuestador    int               IDENTITY(1,1),
    idpersona        int               NOT NULL,
    usuario          varchar(20)       NOT NULL,
    contrasena       varbinary(256)    NOT NULL,
    tipo             char(2)           NOT NULL,
    estado           bit               NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (idencuestador)
)
go



IF OBJECT_ID('Encuestador') IS NOT NULL
    PRINT '<<< CREATED TABLE Encuestador >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Encuestador >>>'
go

/* 
 * TABLE: Ficha 
 */

CREATE TABLE Ficha(
    idficha           int              IDENTITY(1,1),
    idcliente         int              NOT NULL,
    idmanzana         int              NOT NULL,
    tipoconsumidor    char(1)          NOT NULL,
    numhabitantes     int              NOT NULL,
    coordenadax       varchar(30)      NULL,
    coordenaday       varchar(30)      NULL,
    idencuestador     int              NOT NULL,
    estado            char(1)          NOT NULL,
    montopago         decimal(5, 2)    NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (idficha)
)
go



IF OBJECT_ID('Ficha') IS NOT NULL
    PRINT '<<< CREATED TABLE Ficha >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Ficha >>>'
go

/* 
 * TABLE: Manzana 
 */

CREATE TABLE Manzana(
    idmanzana    int           IDENTITY(1,1),
    nombre       varchar(5)    NOT NULL,
    estado       bit           NOT NULL,
    idsector     int           NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (idmanzana)
)
go



IF OBJECT_ID('Manzana') IS NOT NULL
    PRINT '<<< CREATED TABLE Manzana >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Manzana >>>'
go

/* 
 * TABLE: Persona 
 */

CREATE TABLE Persona(
    idpersona        int             IDENTITY(1,1),
    idtipo           int             NOT NULL,
    numdoc           varchar(16)     NOT NULL,
    nombres          varchar(60)     NOT NULL,
    apellidos        varchar(60)     NULL,
    sexo             char(1)         NULL,
    fecnacimiento    date            NULL,
    direccion        varchar(200)    NULL,
    idubigeo         int             NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (idpersona)
)
go



IF OBJECT_ID('Persona') IS NOT NULL
    PRINT '<<< CREATED TABLE Persona >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Persona >>>'
go

/* 
 * TABLE: Sector 
 */

CREATE TABLE Sector(
    idsector       int             IDENTITY(1,1),
    nombre         varchar(30)     NULL,
    descripcion    varchar(100)    NOT NULL,
    estado         bit             NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (idsector)
)
go



IF OBJECT_ID('Sector') IS NOT NULL
    PRINT '<<< CREATED TABLE Sector >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Sector >>>'
go

/* 
 * TABLE: TipoDocumento 
 */

CREATE TABLE TipoDocumento(
    idtipo    int            IDENTITY(1,1),
    nombre    varchar(30)    NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (idtipo)
)
go



IF OBJECT_ID('TipoDocumento') IS NOT NULL
    PRINT '<<< CREATED TABLE TipoDocumento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TipoDocumento >>>'
go

/* 
 * TABLE: Ubigeo 
 */

CREATE TABLE Ubigeo(
    idubigeo           int            IDENTITY(1,1),
    coddepartamento    char(2)        NOT NULL,
    nomdepartamento    varchar(30)    NOT NULL,
    codprovincia       char(2)        NOT NULL,
    nomprovincia       varchar(50)    NOT NULL,
    coddistrito        char(2)        NOT NULL,
    nomdistrito        varchar(80)    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (idubigeo)
)
go



IF OBJECT_ID('Ubigeo') IS NOT NULL
    PRINT '<<< CREATED TABLE Ubigeo >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Ubigeo >>>'
go

/* 
 * TABLE: UnidadUso 
 */

CREATE TABLE UnidadUso(
    idunidaduso    int             IDENTITY(1,1),
    descripcion    varchar(300)    NULL,
    categoria      char(3)         NOT NULL,
    idficha        int             NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (idunidaduso)
)
go



IF OBJECT_ID('UnidadUso') IS NOT NULL
    PRINT '<<< CREATED TABLE UnidadUso >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE UnidadUso >>>'
go

/* 
 * TABLE: Asignacion 
 */

ALTER TABLE Asignacion ADD CONSTRAINT RefEncuestador6 
    FOREIGN KEY (idencuestador)
    REFERENCES Encuestador(idencuestador)
go

ALTER TABLE Asignacion ADD CONSTRAINT RefManzana7 
    FOREIGN KEY (idmanzana)
    REFERENCES Manzana(idmanzana)
go

ALTER TABLE Asignacion ADD CONSTRAINT RefEncuestador8 
    FOREIGN KEY (idsupervisor)
    REFERENCES Encuestador(idencuestador)
go


/* 
 * TABLE: Cliente 
 */

ALTER TABLE Cliente ADD CONSTRAINT RefPersona3 
    FOREIGN KEY (idpersona)
    REFERENCES Persona(idpersona)
go


/* 
 * TABLE: Encuestador 
 */

ALTER TABLE Encuestador ADD CONSTRAINT RefPersona4 
    FOREIGN KEY (idpersona)
    REFERENCES Persona(idpersona)
go


/* 
 * TABLE: Ficha 
 */

ALTER TABLE Ficha ADD CONSTRAINT RefCliente9 
    FOREIGN KEY (idcliente)
    REFERENCES Cliente(idcliente)
go

ALTER TABLE Ficha ADD CONSTRAINT RefManzana10 
    FOREIGN KEY (idmanzana)
    REFERENCES Manzana(idmanzana)
go

ALTER TABLE Ficha ADD CONSTRAINT RefEncuestador11 
    FOREIGN KEY (idencuestador)
    REFERENCES Encuestador(idencuestador)
go


/* 
 * TABLE: Manzana 
 */

ALTER TABLE Manzana ADD CONSTRAINT RefSector5 
    FOREIGN KEY (idsector)
    REFERENCES Sector(idsector)
go


/* 
 * TABLE: Persona 
 */

ALTER TABLE Persona ADD CONSTRAINT RefTipoDocumento1 
    FOREIGN KEY (idtipo)
    REFERENCES TipoDocumento(idtipo)
go

ALTER TABLE Persona ADD CONSTRAINT RefUbigeo2 
    FOREIGN KEY (idubigeo)
    REFERENCES Ubigeo(idubigeo)
go


/* 
 * TABLE: UnidadUso 
 */

ALTER TABLE UnidadUso ADD CONSTRAINT RefFicha12 
    FOREIGN KEY (idficha)
    REFERENCES Ficha(idficha)
go



