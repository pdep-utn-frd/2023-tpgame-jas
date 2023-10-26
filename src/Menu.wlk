import DragonBallFighter.*
import wollok.game.*
import personajes.*
import huds.*

object menuInicio{

	method configuracion(){
        game.clear()
        game.width(18)
        game.height(10)
        game.cellSize(60)
        game.title("Dragon Ball Fighter")
        game.boardGround("pantallas/game_menu.jpg")
        keyboard.j().onPressDo{fondoJuego.iniciar()}
         keyboard.c().onPressDo{menuControles.configuracion()}
         keyboard.s().onPressDo{game.stop()}
    }
}

object menuControles{

    method configuracion(){
        game.clear()
        game.addVisual(fondoMenuControles)
        game.width(18)
        game.height(10)
        game.cellSize(60)
        game.title("Dragon Ball Fighter")
        keyboard.v().onPressDo{menuInicio.configuracion()}
    }
}

object fondoMenuControles{

    method position()=game.at(0,0) 
    method image()="pantallas/game_menu_controles.jpg"
}

object fondoJuego {
    method position()=game.at(0,0) 
    method image()="pantallas/Template Background.jpg"
	
	method chocar(elem){}
	
	
    method iniciar(){
        game.clear()
        pantalla.iniciar()
    }
    
    method reset(){
    	game.clear()
    	pantalla.iniciar()
    	goku.reset()
    	vegeta.reset()
    	hud.reset()
    }

}

object finDelJuego{

    method position()=game.at(0,0) 
    method image()="pantallas/game_over.png"

    method gameOver(){
        game.addVisual(self)
        goku.movementAllowed(false)
        vegeta.movementAllowed(false)
        game.schedule(10000,{game.stop()})
        keyboard.j().onPressDo{fondoJuego.reset()}
        keyboard.q().onPressDo{game.stop()}
    }
}
