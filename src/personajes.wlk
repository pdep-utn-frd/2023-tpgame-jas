import wollok.game.*
import DragonBallFighter.*
import huds.*
import powerUPS.*


//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒PERSONAJE▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████

class Personaje {
	const property enemigo 
	var property nombre 
	var property direccion 
	
	var property image 
	var property vida = 10
	var property ki = 2
	var property position 
	var property movementAllowed = true
	var property danio =1
	
	
	method iniciar (){
		game.whenCollideDo(self,{elemento=> elemento.chocar(self)})
	}
	
	
	method chocar(param){}
	
	
	method mover(direc){
        if (((self.position().x()>0||direc.x()>0)&&(self.position().x()<16||direc.x()<0)) && movementAllowed && direc.x() != 0 ){
            direccion = direc.texto()
            self.position(self.position().right(direc.x()))
            self.direccion(direc.texto())
            game.schedule(0,{self.image(""+nombre+"/"+nombre+"_paso_"+direc.texto()+".png")})
            game.schedule(300,{self.image(""+nombre+"/"+nombre+"_estatico_"+direc.texto()+".png")})
        }

        if (direc.y() > 0 && movementAllowed){
            if(position.y() >= 0 && position.y()<=2){
                self.position(self.position().up(direc.y()))
                game.schedule(0,{self.image(""+nombre+"/"+nombre+"_" +direc.texto()+ self.direccion() + ".png")})
                game.schedule(800,{self.position(self.position().down(2))})
                game.schedule(800,{self.image(""+nombre+"/"+nombre+"_estatico_" + self.direccion() + ".png")})
            }
        }
    }
	    
	/*method ssj(){
    	if (ki>=3 && movementAllowed){
    		danio = 2
    		nombre = nombre+"_SSJ"
    		image = nombre+"/"+nombre+"_estatico_"+self.direccion()+".png"
    		game.schedule(10000,{danio=1})
    		game.schedule(10000,{nombre="Goku"})
    	}
    } */
    
    
    method ataqueEspecial(){}
    
    
 	method perderVida(cant){}
	
	
	method perderKi(cant){}	   


	method verificarRango(lI,lS){
		return(self.position().x()-enemigo.position().x()>=lI && self.position().x()-enemigo.position().x()<=lS)
	}
	
	
	method facing(){
		return ( ((self.verificarRango(-1,0)) &&(self.direccion()=="D"))|| ((self.verificarRango(0,1))&& (self.direccion()=="I")) )
	}
	
	
	method golpear(){
        game.schedule(0,{self.image(""+nombre+"/"+nombre+"_golpe_"+self.direccion()+".png")})
        game.schedule(300,{self.image(""+nombre+"/"+nombre+"_estatico_"+self.direccion()+".png")})
        if (self.facing()){
            enemigo.perderVida(danio)
        }
    } 
    
    
}


//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒GOKU▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████


object goku inherits Personaje(enemigo=vegeta, nombre="Goku", direccion="D", image="Goku/Goku_estatico_D.png", position=game.at(1,0)){
	
	
	override method ataqueEspecial(){
    	var habilidad
    	if (ki>=3 && movementAllowed){
    		self.perderKi(3)
    		game.schedule(0,{self.image("Goku/"+nombre+"_ataque_1_"+self.direccion()+".png")})
    		game.schedule(400,{self.image("Goku/"+nombre+"_ataque_2_"+self.direccion()+".png")})
    		game.schedule(600,{self.image("Goku/"+nombre+"_ataque_2.1_"+self.direccion()+".png")})
    		game.schedule(1200,{self.image("Goku/"+nombre+"_estatico_"+self.direccion()+".png")})
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
    
    
    override method perderVida(cant){
		self.vida((self.vida() - cant).min(10))
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud1,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	
	override method perderKi(cant){
		self.ki((self.ki() - cant).min(5))
		game.say(self, "tengo " + ki + " de ki")
		hud.actualizar(hud1KI,self.ki())
		
	}
    
    

}


//███████████████████████████████████████████████████████████████████████████████
//▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒VEGETA▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
//███████████████████████████████████████████████████████████████████████████████


object vegeta inherits Personaje (enemigo=goku, nombre="Vegeta", direccion="I", image="Vegeta/Vegeta_estatico_I.png", position=game.at(16,0)){
	
	
	override 	method ataqueEspecial(){
		if (ki>=3 && movementAllowed){
			self.perderKi(3)
			game.schedule(0,{self.image("Vegeta/"+nombre+"_tp_"+self.direccion()+".png")})
			if ((enemigo.direccion()=="D") && (enemigo.position().x().between(2,17))){
				game.schedule(500,{self.position(enemigo.position().left(1))})
			}
			else if((enemigo.direccion()=="I") && (enemigo.position().x().between(1,17))){
				game.schedule(500,{self.position(enemigo.position().right(1))})
			}
			else{
				game.schedule(500,{self.position(enemigo.position())})
			}
			game.schedule(800,{self.image("Vegeta/"+nombre+"_tp_"+enemigo.direccion()+".png")})
			game.schedule(1000,{self.image("Vegeta/"+nombre+"_estatico_"+enemigo.direccion()+".png")})
		}
	}
	
	
    override method perderVida(cant){
		self.vida((self.vida() - cant).min(10))
		game.say(self, "tengo " + vida + " de vida")
		hud.actualizar(hud2,self.vida())
		if(self.vida() <= 0){
			finalizarPartida.gameOver()
		}
	}
	
	
	override method perderKi(cant){
		self.ki((self.ki() - cant).min(5))
		game.say(self, "tengo " + ki + " de ki")
		hud.actualizar(hud2KI,self.ki())
		
	}

}




class Movimiento {
    const property x
    const property y
    const property texto
}


const arriba = new Movimiento (x = 0, y = 2, texto = "salto_")
const der = new Movimiento (x = 1, y = 0, texto = "D")
const izq = new Movimiento (x = -1, y = 0, texto = "I")
