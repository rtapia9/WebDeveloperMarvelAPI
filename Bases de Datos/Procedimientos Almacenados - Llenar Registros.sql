
--
--	Procedimientos almacenados para llenar las tablas una vez que tengamos el Json
--	llamaremos a los procedimientos alamcenados para sincronizar la información
--	obtenida de los comics.
--	Es necesario iterar en la lectura de los creators y characters y en cada iteracción
--	llamar al procemiento almacenado correspondiente:
--				PA_SincronizaciónCreator
--				PA_SincronizaciónHeroe
--	en ambos indicaremos el Id del comic
--




--	Procedimiento almacenado para insertar los datos del comic
--		Cuando llamemos al procedimiento necesitaremos pasar como argumento
--			los datos del json :
--			PA_SincronizaciónComic(id, title, resourceURI)

CREATE OR REPLACE PROCEDURE marvel.PA_SincronizaciónComic(INT, VARCHAR(100), VARCHAR(200))
	language plpgsql
	AS $$
		BEGIN
			INSERT INTO marvel.Comics VALUES ($1,$2,$3);
			COMMIT;
		END;
	$$;



--		Procedimiento almacenado para insertar los datos de los creadores
--		Cuando llamemos al procedimiento necesitaremos pasar como argumento
--			los datos del json :
--			PA_SincronizaciónCreator( name, role, resourceURI,[Id del comic])


CREATE OR REPLACE PROCEDURE marvel.PA_SincronizaciónCreator(VARCHAR(60), VARCHAR(20), VARCHAR(60), comic INT)
	language plpgsql
	AS $$
		DECLARE ID INT;
		BEGIN	
			ID := CAST(SUBSTR($3,46,51) AS INT);
			
				INSERT INTO marvel.Creadores VALUES (ID,$1,$2,$3);
				INSERT INTO marvel.Colaboradores VALUES (comic,ID);
			COMMIT;
		END;
	$$;



--		Procedimiento almacenado para insertar los datos de los creadores
--		Cuando llamemos al procedimiento necesitaremos pasar como argumento
--			los datos del json :
--			PA_SincronizaciónHeroe( name, resourceURI, [Id del comic])


CREATE OR REPLACE PROCEDURE marvel.PA_SincronizaciónHeroe(VARCHAR(50), VARCHAR(60),comic INT)
	language plpgsql
	AS $$
		DECLARE ID INT;
		BEGIN
			ID := CAST(SUBSTR($2,48,55) AS INT);

			INSERT INTO marvel.Heroes VALUES (ID,$1,$2);
			INSERT INTO marvel.Superheroes VALUES (comic,ID);
			COMMIT;
		END;
	$$;


