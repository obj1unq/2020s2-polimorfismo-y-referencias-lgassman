/*
 * Recordá que:
 *  ```
 *    var property x
 *  ``` 
 * 
 * es equivalente a escribir:
 * 
 *  ```
 *   var x
 *   method x() { return x }
 *   method x(_x) { x = _x}
 * ```
 * 
 */

object virtuoso {
	var property instrumento = guitarraElectrica
	
	method suenaLindo() {
		return true 
	}
	
	method tocar() {
		//repite 10 veces instrumento.usar(). 
		//En index está el número de iteración aunque no lo usemos.
		10.times { index =>
			instrumento.usar()
		}
	}
	
	method instrumentoViejo(){
		return instrumento.usos() >= 20
	}
}

object principiante {
	var property instrumento = guitarraElectrica
	
	method suenaLindo () {
		 return not instrumento.gastado()
	}

	method tocar() {
		instrumento.usar()
	}

	method instrumentoViejo(){
		return false
	}
	
}

object guitarraElectrica {
	var property equipo = equipoChico
	var property usos = 1
	
	method usar() {
		usos++ 	
		if(usos < 20) {
			equipo.usar()
		}
	}
	
	method gastado() {
		return usos > 3 or equipo.gastado()
	}
	
}

object equipoChico {
	
	var usosRestantes = 6
	
	method usar() {
		usosRestantes = (usosRestantes - 1).max(0)
	}
	
	method gastado() {
		return usosRestantes == 0
	}
	
	method usos() {
		return 6 - usosRestantes;
	}
}




