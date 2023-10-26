import DragonBallFighter.*
import wollok.game.*
import personajes.*



//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒Spawners▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████


object spawner {
    var property lista_spawneables = ["Semilla","Semilla","Orbe","Orbe","Roca"]
    var property velocidadSpawn = 6000


    method iniciar() {
        game.onTick(velocidadSpawn,"spawner",{self.spawn()})
    }
    
    
    method spawn(){
    	const nuevaMejora = lista_spawneables.anyOne()
    	if (nuevaMejora == "Semilla"){
    		var newPowerUp = new Semilla(downSpeed=300, image="powerUps/mejora_semilla.png")
    		newPowerUp.spawn()
    	}
    	else if (nuevaMejora == "Orbe") {
    		var newPowerUp = new Orbe(downSpeed=300, image="powerUps/elemento_orbe.png")
    		newPowerUp.spawn()
    	}
    	else {
    		const piedras=[new Piedra(downSpeed=100, image="powerUps/roca.png"),new Piedra(downSpeed=100, image="powerUps/roca.png"),new Piedra(downSpeed=100,image="powerUps/roca.png")]
    		piedras.forEach({piedrita=>piedrita.spawn()})
    		piedras.clear()
    	}
    }
}


//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒Mejoras▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████

class Mejoras{
	var property image = ""
	var property position = game.at(-2,-2)
	const lista = new Range(start=0, end = 18)
	const property tipo = "powerUp"
	var property downSpeed
		
		
	method buff(elemento){}
	
	
	method spawn(){
		game.addVisual(self)
		position = game.at(lista.anyOne(),10)
		game.onTick(downSpeed,"disminuir posicion Y en 1",{self.checkMovement()})
	}
	
	method checkMovement(){
		position=position.down(1)
		if (position.y()<0){
			game.removeTickEvent("disminuir posicion Y en 1")
			game.removeVisual(self)
		}
	}
	
	
	method chocar(elemento){
		self.buff(elemento)
		//game.removeTickEvent("disminuir posicion Y en 1")
		game.removeVisual(self)
	}
}

class Semilla inherits Mejoras{
	
	
	override method buff(elemento) {
		elemento.perderVida(-2)
	}
	
}

class Orbe inherits Mejoras{
	
	override method buff(elemento){
		elemento.perderKi(-1)
	}
}

class Piedra inherits Mejoras{
	
	
	override method image()="powerUps/roca.png"
	
	
	override method buff(elemento){
		var oldImage = elemento.image()
		elemento.movementAllowed(false)
		elemento.image(elemento.nombre()+"/"+elemento.nombre()+"_estatico_piedra_D.png")
		game.schedule(2000,{elemento.image(oldImage)})
		game.schedule(2000,{elemento.movementAllowed(true)})
	}
}



//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒KameHameHa▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████

class KameHameHa {
	var property position = game.at(-2,-2)
	var property image
	
	
	method cast(direccion){
			position = goku.position().right(direccion.x())
			game.addVisual(self)
			game.onTick(120,"kamehameha",{self.avance(direccion)})
	}


	method chocar(personaje){
		personaje.perderVida(5)
		game.removeTickEvent("kamehameha")
		game.removeVisual(self)
	}
	
	
	method avance(direccion){
		if (self.position().x().between(-1,19)){
			game.schedule(0,{self.image("kamehameha/kamehameha_1_"+direccion.texto()+".png")})
			game.schedule(50,{self.position(self.position().right(direccion.x()))})
			game.schedule(100,{self.image("kamehameha/kamehameha_2_"+direccion.texto()+".png")})
		}
		else{
			game.removeTickEvent("kamehameha")
			game.removeVisual(self)
		}
	
	}
}