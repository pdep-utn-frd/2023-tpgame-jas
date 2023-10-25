import wollok.game.*

// Configuración de la pantalla y mecánicas de juego

object pantalla{
	
	var property lista=["1","2","3","4","5","6","7","8","9"]
	var property indice = 0
	
	method iniciar(){
		self.configuracionDelTablero()
		self.visualesEnPantalla()
		self.programarTeclas()
		hud.iniciar()
		spawner.iniciar()
		goku.iniciar()
		vegeta.iniciar()
		game.boardGround("Fondo/transicion1.jpg")
		
	}
	
	
	
	method configuracionDelTablero(){
		game.width(18)
		game.height(10)
		game.cellSize(60)
		game.title("Dragon Ball Fighter")
		game.boardGround("color gris.png")
	}
	
	method visualesEnPantalla(){
		game.addVisual(goku)
		game.addVisual(vegeta)
	}
	
	method programarTeclas(){
        keyboard.d().onPressDo{goku.mover(der)}
        keyboard.a().onPressDo{goku.mover(izq)}
        keyboard.w().onPressDo{goku.mover(arriba)}
        keyboard.s().onPressDo{goku.golpear()}
        keyboard.right().onPressDo{vegeta.mover(der)}
        keyboard.left().onPressDo{vegeta.mover(izq)}
        keyboard.up().onPressDo{vegeta.mover(arriba)}
        keyboard.down().onPressDo{vegeta.golpear()}
        keyboard.shift().onPressDo{vegeta.ataqueEspecial()}
        keyboard.r().onPressDo{goku.ataqueEspecial()}
    }
	
}

object finalizarPartida{
	
	var property position = game.center()
	var property text ="¡Game Over!"
	
	method gameOver(){
		game.addVisual(self)
		game.schedule(10000,{game.stop()})
	}
}



// Personajes

object goku{
	const enemigo = vegeta
	const property nombre= "Goku"
	var property direccion = "D"
	const property tipo = "jugador"
	
	var property image = "Goku/Goku_estatico_"+self.direccion()+".png"
	var property vida = 10
	var property ki = 0
	var property position = game.at(1,0)
	var property movementAllowed = true

	method iniciar (){
		game.whenCollideDo(self,{elemento=> elemento.chocar(self)})
	}
	method chocar(param){}
	

	
	method mover(direc){
        if (((self.position().x()>0||direc.x()>0)&&(self.position().x()<16||direc.x()<0)) && movementAllowed && direc.x() != 0 ){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.direccion(direc.texto())
            game.schedule(0,{self.image("Goku/Goku_paso_"+direc.texto()+".png")})
            game.schedule(300,{self.image("Goku/Goku_estatico_"+direc.texto()+".png")})
        }

        if (direc.y() > 0 && movementAllowed){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Goku/Goku_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Goku/Goku_estatico_" + self.direccion() + ".png")})
            }
        }
       }
    method ataqueEspecial(){
    	var habilidad
    	if (ki>=3 && movementAllowed){
    		ki-=3
    		game.schedule(0,{self.image("Goku/Goku_ataque_1_"+self.direccion()+".png")})
    		game.schedule(400,{self.image("Goku/Goku_ataque_2_"+self.direccion()+".png")})
    		game.schedule(600,{self.image("Goku/Goku_ataque_2.1_"+self.direccion()+".png")})
    		game.schedule(1200,{self.image("Goku/Goku_estatico_"+self.direccion()+".png")})
    		if (direccion=="D"){
    			habilidad = new KameHameHa(image="kamehameha/kamehameha_2_"+self.direccion()+".png")
    			game.schedule(500,{habilidad.cast(der)})
    		}
    		else{
    			habilidad = new KameHameHa(image="kamehameha/kamehameha_2_"+self.direccion()+".png")
    			game.schedule(500,{habilidad.cast(izq)})
    		}
    	}
    }

	method perderVida(cant){
		self.vida((self.vida() - cant).min(10))
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud1,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	method perderKi(cant){
		self.ki((self.ki() - cant).min(5))
		game.say(self, "tengo " + ki + " de ki")
		hud.actualizar(hud1KI,self.ki())
		
	}
	
	method verificarRango(lI,lS){
		return(self.position().x()-enemigo.position().x()>=lI && self.position().x()-enemigo.position().x()<=lS)
	}
	
	method facing(){
		return ( ((self.verificarRango(-1,0)) &&(self.direccion()=="D"))|| ((self.verificarRango(0,1))&& (self.direccion()=="I")) )
	} //A lo ultimo verificar si solo se usa una vez.
	
	method golpear(){
        game.schedule(0,{self.image("Goku/Goku_golpe_"+self.direccion()+".png")})
        game.schedule(300,{self.image("Goku/Goku_estatico_"+self.direccion()+".png")})
        if (self.facing()){
            enemigo.perderVida(1)
        }
    }
}

object vegeta{
	const enemigo = goku
	var property direccion = "I"
	const property tipo = "jugador"
	const property nombre= "Vegeta"
	
	var property image = "Vegeta/Vegeta_estatico_I.png"
	var property vida = 10
	var property ki = 5
	var property position = game.at(8,0)
	var property movementAllowed = true
	
	method iniciar (){
		game.whenCollideDo(self,{elemento=> elemento.chocar(self)})
	}
	
	method chocar(param){}
	
	method mover(direc){
        if (((self.position().x()>0||direc.x()>0)&&(self.position().x()<16||direc.x()<0)) && movementAllowed && direc.x() != 0 ){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.direccion(direc.texto())
            game.schedule(0,{self.image("Vegeta/Vegeta_paso_"+direc.texto()+".png")})
            game.schedule(300,{self.image("Vegeta/Vegeta_estatico_"+direc.texto()+".png")})
        }

        if (direc.y() > 0 && movementAllowed){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Vegeta/Vegeta_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Vegeta/Vegeta_estatico_" + self.direccion() + ".png")})
            }
        }
       }
	
	method ataqueEspecial(){
		if (ki>=0 && movementAllowed){
			//ki-=3
			game.schedule(0,{self.image("Vegeta/Vegeta_tp_"+self.direccion()+".png")})
			if ((enemigo.direccion()=="D") && (enemigo.position().x().between(2,17))){
				game.schedule(500,{self.position(enemigo.position().left(1))})
			}
			else if((enemigo.direccion()=="I") && (enemigo.position().x().between(1,17))){
				game.schedule(500,{self.position(enemigo.position().right(1))})
			}
			else{
				game.schedule(500,{self.position(enemigo.position())})
			}
			game.schedule(800,{self.image("Vegeta/Vegeta_tp_"+enemigo.direccion()+".png")})
			game.schedule(1000,{self.image("Vegeta/Vegeta_estatico_"+enemigo.direccion()+".png")})
		}
	}
	
	method perderVida(cant){
		self.vida((self.vida() - cant).min(10))
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud2,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	
	method perderKi(cant){
		self.ki((self.ki() - cant).min(5))
		game.say(self, "tengo " + ki + " de ki")
		hud.actualizar(hud2KI,self.ki())
		
	}
	
	method verificarRango(lI,lS){
		return(self.position().x()-enemigo.position().x()>=lI && self.position().x()-enemigo.position().x()<=lS)
	}
	
	method facing(){
		return ( ((self.verificarRango(-1,0)) &&(self.direccion()=="D"))|| ((self.verificarRango(0,1))&& (self.direccion()=="I")) )
	} //A lo ultimo verificar si solo se usa una vez.
	
	method golpear(){
        game.schedule(0,{self.image("Vegeta/Vegeta_golpe_"+self.direccion()+".png")})
        game.schedule(300,{self.image("Vegeta/Vegeta_estatico_"+self.direccion()+".png")})
        if (self.facing()){
            enemigo.perderVida(1)
        }
	}
	
}



object hud {
	const elementos = [hud1,hud2,hud3,hud4,hud1KI,hud2KI]
	method position() = game.at(0,11)
	method iniciar() {
		elementos.forEach({elemento => game.addVisual(elemento)})
	}
	method actualizar(nombre,vida) {
		nombre.actualizar(vida)
	}
	method terminar() {
		elementos.forEach({elemento => game.removeVisual(elemento)})
	}
}


object hud1 {
	var property image = "img_vida_P1/vida_p1_10.png"
	method position() = game.at(0,8)
	method actualizar (vida) {
		image = "img_vida_P1/vida_p1_" + vida.max(0) +".png"}
}

object hud1KI {
	var property image= "img_vida_P1/hud_ki_p1_0.png"
	method position()=game.at(0,8)
	method actualizar (ki){
		image= "img_vida_P1/hud_ki_p1_" + ki.max(0) +".png"
	}
}

object hud2KI {
	var property image= "img_vida_P2/hud_ki_p2_0.png"
	method position()=game.at(13,8)
	method actualizar (ki){
		image= "img_vida_P2/hud_ki_p2_" + ki.max(0) +".png"
	}
}

object hud2 {
    var property image = "img_vida_P2/vida_p2_10.png"
    method position() = game.at(13,8)
   	method actualizar (vida) {
     	image = "img_vida_P2/vida_p2_" + vida.max(0) + ".png"
   }
}

object hud3 {
	var property image="img_vida_P1/hud_p1.png"
	method position()= game.at(0,8)
}

object hud4 {
	var property image="img_vida_P2/hud_p2.png"
	method position()= game.at(13,8)
}

class Movimiento {
    const property x
    const property y
    const property texto
}

const arriba = new Movimiento (x = 0, y = 2, texto = "salto_")
const der = new Movimiento (x = 1, y = 0, texto = "D")
const izq = new Movimiento (x = -1, y = 0, texto = "I")


object spawner {
    var property lista_spawneables = ["Semilla","Semilla","Orbe","Orbe","Roca"]
    var property velocidadSpawn = 6000

    method iniciar() {
        game.onTick(velocidadSpawn,"spawner",{self.spawn()})
    }
    
    method spawn(){
    	const nuevaMejora = lista_spawneables.anyOne()
    	if (nuevaMejora == "Semilla"){
    		var newPowerUp = new Semilla(downSpeed=300)
    		newPowerUp.spawn()
    	}
    	else if (nuevaMejora == "Orbe") {
    		var newPowerUp = new Orbe(downSpeed=300)
    		newPowerUp.spawn()
    	}
    	else {
    		const piedras=[new Piedra(downSpeed=100),new Piedra(downSpeed=100),new Piedra(downSpeed=100),new Piedra(downSpeed=100)]
    		piedras.forEach({piedrita=>piedrita.spawn()})
    		piedras.clear()
    	}
    }
}

class Mejoras{
	var property image = ""
	var property position = game.at(-1,-1)
	const lista = new Range(start=0, end = 18)
	const property tipo = "powerUp"
	var property downSpeed
		
	method buff(elemento){}
	
	method spawn(){
		game.addVisual(self)
		position = game.at(lista.anyOne(),10)
		game.onTick(downSpeed,"disminuir posicion Y en 1",{self.position(self.position().down(1))})
	}
	
	method chocar(elemento){
		game.removeVisual(self)
		self.buff(elemento)
	}
}

class Semilla inherits Mejoras{
	
	override method image() = "powerUps/mejora_semilla.png"
	override method buff(elemento) {
		elemento.perderVida(-2)
	}
	
}

class Orbe inherits Mejoras{
	override method image() = "powerUps/elemento_orbe.png"
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

// Objetos