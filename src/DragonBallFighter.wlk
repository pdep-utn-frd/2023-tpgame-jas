import wollok.game.*

// Configuración de la pantalla y mecánicas de juego

object pantalla{
	
	method iniciar(){
		self.configuracionDelTablero()
		self.visualesEnPantalla()
		self.programarTeclas()
		hud.iniciar()
		spawner.iniciar()
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
        keyboard.f().onPressDo{goku.golpear()}
        keyboard.right().onPressDo{vegeta.mover(der)}
        keyboard.left().onPressDo{vegeta.mover(izq)}
        keyboard.up().onPressDo{vegeta.mover(arriba)}
        keyboard.s().onPressDo{goku.perderVida()}
    }
	
}

object finalizarPartida{
	
	var property position = game.center()
	var property image = "vida.png"
	
	method gameOver(){
		game.addVisual(self)
	}
}



// Personajes

object goku{
	var enemigo = vegeta
	var property direccion = "D"
	const property tipo = "jugador"
	
	var property image = "Goku_estatico_"+self.direccion()+".png"
	var property vida = 10
	var property position = game.at(1,0)

	
	method mover(direc){
        if (direc.x() != 0){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.direccion(direc.texto())
            self.image("Goku_estatico_"+direc.texto()+".png")
        }

        if (direc.y() > 0){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Goku_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Goku_estatico_" + self.direccion() + ".png")})
            }
        }
       }

	method perderVida(){
		self.vida(self.vida() - 1)
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud1,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	method verificarRango(lI,lS){
		return(self.position().x()-enemigo.position().x()>=lI && self.position().x()-enemigo.position().x()<=lS)
	}
	
	method facing(){
		return ( ((self.verificarRango(-1,0)) &&(self.direccion()=="D"))|| ((self.verificarRango(0,1))&& (self.direccion()=="I")) )
	} //A lo ultimo verificar si solo se usa una vez.
	
	method golpear(){
        game.schedule(0,{self.image("Pegar_"+self.direccion()+".png")})
        game.schedule(300,{self.image("Goku_estatico_"+self.direccion()+".png")})
        if (self.facing()){
            enemigo.perderVida()
        }
    }
}

object vegeta{
	var enemigo = goku
	var property direccion = "I"
	const property tipo = "jugador"
	
	var property image = "Goku_estatico_I.png"
	var property vida = 10
	var property position = game.at(8,0)
	
		
	method mover(direc){
        if (direc.x() != 0){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.image("Goku_estatico_"+direc.texto()+".png")
            self.direccion(direc.texto())
        }

        if (direc.y() > 0){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image("Goku_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(400,{self.position(self.position().down(2))})
                game.schedule(400,{self.image("Goku_estatico_" + self.direccion() + ".png")})
            }
        }
       }
	
	
	method perderVida(){
		self.vida(self.vida() - 1)
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud2,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	method golpear(){
		game.schedule(0,{self.image("dasdas.png")})
		game.schedule(300,{self.image("Goku_estatico.png")})
		if ((self.position().x())+1 == enemigo.position()){
			enemigo.perderVida()
		}
	}
	
}

object hud {
	const elementos = [hud1,hud2,hud3,hud4]
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
	method position() = game.at(0,9)
	method actualizar (vida) {
		image = "img_vida_P1/vida_p1_" + vida.max(0) +".png"}
}

object hud2 {
    var property image = "img_vida_P2/vida_p2_10.png"
    method position() = game.at(13,9)
   	method actualizar (vida) {
     	image = "img_vida_P2/vida_p2_" + vida.max(0) + ".png"
   }
}

object hud3 {
	var property image="img_vida_P1/hud_p1.png"
	method position()= game.at(0,9)
}

object hud4 {
	var property image="img_vida_P2/hud_p2.png"
	method position()= game.at(13,9)
}

class Movimiento {
    const property x
    const property y
    const property texto
}

const arriba = new Movimiento (x = 0, y = 2, texto = "salto_")
const der = new Movimiento (x = 1, y = 0, texto = "D")
const izq = new Movimiento (x = -1, y = 0, texto = "I")

class Mejoras{
	var property image = ""
	var property position = game.at(-1,-1)
	const lista = new Range(start=0, end = 18)
		
	
	/*method chocar(entidad){
		if(entidad.tipo()=="jugador"){
			game.onCollideDo(entidad,{self.buff(entidad)})
			self.buff(self)
			game.removeVisual(self)
		}
	}*/
	
	
	method buff(mejora){}
	
	method spawn(){
		game.addVisual(self)
		position = game.at(lista.anyOne(),10)
		game.onTick(200,"dismibuir posicion Y en 1",{self.position().y() - 1})
	}
}

object spawner {
    var property lista_spawneables = [semilla = new Mejoras()]
    const property velocidadSpawn = 2

    method iniciar() {
        game.onTick(velocidadSpawn,"spawner",{lista_spawneables.anyOne().spawn()})
    }
}

object semilla inherits Mejoras{
	
	override method image() = "semilla.png"
	
}


// Objetos