object paquete {

	var property cantidadPersonas = 1 // un numero
	var property servicioOfrecido = servicio // hotel, traslado, combinado
	var property premium = false // un booleano 
	var reservado = false

	method estaReservado() {
		return reservado
	}

	// Se puede reservar si no esta reservado y el servicio se puede reservar
	method sePuedeReservar() {
		if (self.estaReservado()) {
			return false
		}
		if (servicioOfrecido.esHotel()) { // Un hotel se puede reservar si hay lugares disponibles. 
		// Ademas, si el paquete es premium el hotel tiene que ser
		// como minimo de 4 estrellas
			return servicioOfrecido.camasDisponibles() >= cantidadPersonas and 
					(not premium or (servicioOfrecido.estrellas() >= 4 and servicioOfrecido.spaDisponible())) 
		}
		
		if (servicioOfrecido.esVehiculoParaTralado()) {
			// Un traslado se puede reservar si el vehiculo cuenta con 
			// lugares disponibles y tiene la verificacion tecnica al dia.
			// Si el paquete es premium, tambien tiene que cumplir que  
			// tenga aire Acondicionado
			return servicioOfrecido.asientosDisponibles() >= cantidadPersonas and servicioOfrecido.tieneVTV() and (not premium or servicioOfrecido.tieneAireAcondicionado())
		}
		if (servicioOfrecido.esCombinado()) {
			// Si es combinado tiene que cumplir el requierimiento del hotel y del vehiculo
			return servicioOfrecido.camasDisponibles() >= cantidadPersonas and 
					(not premium or (servicioOfrecido.estrellas() >= 4 and servicioOfrecido.spaDisponible())) and 
						servicioOfrecido.asientosDisponibles() >= cantidadPersonas and servicioOfrecido.tieneVTV() 
						and (not premium or servicioOfrecido.tieneAireAcondicionado())
		}
		return false // ??		
	}

	// Cuando se reserva se cambia el estado y se modifican los lugares 
	// disponibles en los servicios
	method reservar() {
		
		if(servicioOfrecido.esVehiculoParaTralado()){
			servicioOfrecido.asientosDisponibles(servicioOfrecido.asientosDisponibles() - cantidadPersonas)
		}
		
		if(servicioOfrecido.esHotel()) {
			servicioOfrecido.camasDisponibles(servicioOfrecido.camasDisponibles() - cantidadPersonas)
			if (premium) {
				servicioOfrecido.reservarSpa()
			}
		}
				
		if(servicioOfrecido.esCombinado()) {
			servicioOfrecido.asientosDisponibles(servicioOfrecido.asientosDisponibles() - cantidadPersonas)
			servicioOfrecido.camasDisponibles(servicioOfrecido.camasDisponibles() - cantidadPersonas)
			if (premium) {
				servicioOfrecido.reservarSpa()
			}
			
		}
		reservado = true
	}

}

object servicio {

	var property asientosDisponibles = 10 // lugares disponibles del VEHICULO
	var property camasDisponibles = 30 // camas disponibles del HOTEL
	var estrellas = 1 // cantidad de estrellas del HOTEL
	var aireAcondicionado = false // si el VEHICULO tiene  aire acond.
	var vtv = true // si el VEHICULO tiene la vtv
	var spaDisponible = true // si el HOTEL tiene spa disponible
	var esHotel = false
	var esVehiculoParaTraslado = false
	var esCombinado = false

	method reservarSpa() {
		spaDisponible = false
	;
	}

	method configurarComoHotel(_estrellas, _camas, _spaDisponible) {
		esHotel = true
		esCombinado = false
		esVehiculoParaTraslado = false
		estrellas = _estrellas
		camasDisponibles = _camas
		spaDisponible = _spaDisponible
	}

	method configurarComoVehiculo(_tieneAire, _tieneVtv, _asientosDisponibles) {
		esHotel = false
		esCombinado = false
		esVehiculoParaTraslado = true
		aireAcondicionado = _tieneAire
		vtv = _tieneVtv
		asientosDisponibles = _asientosDisponibles
	}

	method configurarComoCombinado(_estrellas, _camas, _spaDisponible, _tieneAire, _tieneVtv, _asientosDisponibles) {
		esHotel = false
		esCombinado = true
		esVehiculoParaTraslado = false
		estrellas = _estrellas
		camasDisponibles = _camas
		spaDisponible = _spaDisponible
		aireAcondicionado = _tieneAire
		vtv = _tieneVtv
		asientosDisponibles = _asientosDisponibles
	}

	method esHotel() {
		return esHotel
	}
	
	method esCombinado() {
		return esCombinado
	}

	method esVehiculoParaTralado() {
		return esVehiculoParaTraslado
	}

	method estrellas() {
		return estrellas
	}

	method tieneAireAcondicionado() {
		return aireAcondicionado
	}

	method tieneVTV() {
		return vtv
	}

	method spaDisponible() {
		return spaDisponible
	}

}

