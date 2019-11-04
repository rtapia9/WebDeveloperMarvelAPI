--
--	Creamos la base de datos BD_COMICS_MARVEL
--	primero verificamos si la base de datos existe,
--	si existe la borramos y creamos una base nueva
DROP DATABASE IF EXISTS BD_COMICS_MARVEL;
CREATE DATABASE BD_COMICS_MARVEL;

--Ingresamos a nuestra base de datos creada anteriormente
--
\c bd_comics_marvel 

--	Creamos un esquema de datos, 
--  Para que las tablas pertenezcan al esquema Marvel y no
--	al esquema public por default.
CREATE SCHEMA marvel;

--Creamos un usuario especifico para la base de datos
CREATE USER Admin_marvel WITH ENCRYPTED PASSWORD 'marvelcomics' LOGIN;



--	Tablas principales, en ellas se almacenará lo mas importante
--	que recabemos de los comics, Tablas catalogos, nosotros ingresaremos 
--	 la información necesaria para mantenerla actualizada.
--	Antes de crear las tablas verificamos si existen, y si eso es correcto,
--	las borramos y creamos la nueva tabla para trabjar sobre ella


--	Tabla Comics -->  el Json del API Marvel, nos da la información completa 
--	para llenar esta tabla  
--	Dentro el Objeto Comic recuperamos (id, title, urls[0].url)
DROP TABLE IF EXISTS marvel.Comics;
CREATE TABLE marvel.Comics(
	ID_COMIC INT UNIQUE,
	TITLE VARCHAR(100),
	RESOURCEURI VARCHAR(200),
	PRIMARY KEY (ID_COMIC)
);

--	Tabla Creadores --> aqui solo obtenemos del Json
--	 los valores (name, role, resourceURI)
--	para obtener el valor de los ID del creador utilizaremos 
--	el campo resourceURI
DROP TABLE IF EXISTS marvel.Creadores;
CREATE TABLE marvel.Creadores (
	ID_CREATOR INT UNIQUE,
	NAME VARCHAR(60),
	ROLE VARCHAR(20),
	RESOURCEURI VARCHAR(60),
	PRIMARY KEY(ID_CREATOR)
);
--	Tabla Heroes --> del json obtenemos (name, ResourceURI)
--	para obtener el valor de los ID del Heroe utilizaremos 
--	el campo resourceURI
DROP TABLE IF EXISTS marvel.Heroes;
CREATE TABLE marvel.Heroes(
	ID_HEROE INT UNIQUE,
	NAME VARCHAR(50),
	RESOURCEURI VARCHAR(60)
);


--	ENTIDADES DE RELACIÓN ENTRE LAS TABLAS

--	Tablas para tener la relacíón de los comics con los creadores
--	 y los comics con los superheroes involucrados..
DROP TABLE IF EXISTS marvel.Colaboradores;
CREATE TABLE marvel.Colaboradores(
	ID_COMICS INT,
	ID_CREATORS INT,
	PRIMARY KEY(ID_COMICS,ID_CREATORS),
	FOREIGN KEY(ID_COMICS) REFERENCES marvel.Comics(ID_COMIC) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_CREATORS) REFERENCES marvel.Creadores(ID_CREATOR) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS marvel.Superheroes;
CREATE TABLE marvel.Superheroes(
	ID_COMICS INT,
	ID_SUPERHEROE INT,
	PRIMARY KEY(ID_COMICS,ID_SUPERHEROE),
	FOREIGN KEY(ID_COMICS) REFERENCES marvel.Comics(ID_COMIC) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_SUPERHEROE) REFERENCES marvel.Heroes(ID_HEROE) ON DELETE CASCADE ON UPDATE CASCADE 
);

--	Falta el detalle de las regalias que se aplicará a los creadores (Writers, Editors y Colorists)