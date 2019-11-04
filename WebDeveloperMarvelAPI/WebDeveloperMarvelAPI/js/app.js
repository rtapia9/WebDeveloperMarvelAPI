const marvel ={
	render: () => {
		
//
//       URL PARA IRON MAN
//       const urlAPI = 'https://gateway.marvel.com:443/v1/public/characters/1009368/comics?limit=100&ts=1&apikey=e1df5a661d2d39b3fc16453c8c6d9324&hash=e9f8bf60014c1f16e8ff460421b8a2c0';
        
//
//      URL PARA CAPTAIN AMERICA
        const urlAPI = 'https://gateway.marvel.com:443/v1/public/characters/1009220/comics?limit=100&ts=1&apikey=e1df5a661d2d39b3fc16453c8c6d9324&hash=e9f8bf60014c1f16e8ff460421b8a2c0';




        const container = document.querySelector("#marvel-row");
		let contenidoHTML = '';

		//Realizamos el fetch a nuestra API
		fetch(urlAPI)
		.then(res => res.json())
		.then( (json) => {
				console.log(json, 'RES.JSON')       //impresion de consola para ver que datos arroja ya hacer la base de datos  
        
        for(const comic of json.data.results){
                let urlcomic = comic.urls[0].url;
                
                var heroes = comic.characters.available;
                var autores = comic.creators.available;
                

                contenidoHTML += `
                    <div class="col-md-6">
                        <a href="${urlcomic}" target="_blank">
                            <img src="${comic.thumbnail.path}.${comic.thumbnail.extension}" alt="${comic.series.name}" class="img-thumbnail">
                        </a>
                   
                        <h3 class="title">Comic: ${comic.title}</h3>
                       <h3 class="subtitle">Heroes involucrados: ${heroes}</h3>
                       <h3 class="title"> Creadores del comic: ${autores} </h3> 
                    </div> `;

            }
            container.innerHTML = contenidoHTML;  
        
		})
	}
};
marvel.render();


//***************************************************************************************************************************************************
//
//          El json nos arroja un objeto por cada comic, dentro del obtenemos las datos necesatrios para la sincronización de la base y la API
//              
//          Para los datos del comic obtenemos 
//                  titulo =>  comic.title
//                  id     =>  comic.id
//                  url    =>  comic.urls[0].url
//
//          Para los datos de los creadores
//                 nombre       => comic.creators.items[#].name
//                 rol          => comic.creators.items[#].role
//                 resourceURI  => comic.creators.items[#].resourceURI
//              De este último campo podemos deducir el id del creador para mantener congruencia en la información
//
//          Para los datos de los personajes que interactuan con el Heroe principal
//                  nombre          => comic.characters.items[#].name
//                  resourceURI     => comic.characters.items[#].resourceURI
//              De este último igual podemos deducir cual es el íd del personaje
//
//
//          Para poder manejar los creadores y los characters necesitaremos itererar ese objeto y leer
//              cada elemento , así mismo llamaremos a nuestro procedimiento almacenado para hacer la sincronizacion de lo que nos arroja la busqueda 
//                  con la base de datos
//
//              Para manejar los datos de eso objetos tomaremos el valor de 
//                          comic.creators.available  y  comic.characters.available
//                  que nos indica el numero de elementos que nos arroja, y por cada uno llamaremos a nuestro store procedure
//
//              Cada que lea un valor, mandarlo al curpo del HTML para que pueda visualizar toda la infomación recolectada por comic******
//
//
//***************************************************************************************************************************************************