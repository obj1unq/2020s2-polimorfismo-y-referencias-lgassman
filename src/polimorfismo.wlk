object paquete {

	var property cantidadPersonas = 1 // un numero
	var property servicioOfrecido = servicioCombinado // hotel, traslado, combinado
	var property premium = false // un booleano 
	var reservado = false

	method estaReservado() {
		return reservado
	}

	// Se puede reservar si no esta reservado y el servicio se puede reservar
	method sePuedeReservar() {
		return not self.estaReservado() and servicioOfrecido.sePuedeReservar(self)
	}

	// Cuando se reserva se cambia el estado y se modifican los lugares 
	// disponibles en los servicios
	method reservar() {
		servicioOfrecido.reservar(self)
		reservado = true
	}

}

object hotel {
	
	var property camasDisponibles = 30 // camas disponibles del HOTEL
	var property estrellas = 1 // cantidad de estrellas del HOTEL
	var property spaDisponible = true // si el HOTEL tiene spa disponible
	
	method sePuedeReservar(paquete) {
		return self.camasDisponibles() >= paquete.cantidadPersonas() and 
					(not paquete.premium() or (self.estrellas() >= 4 and self.spaDisponible())) 
	}
	
	method reservar(paquete) {
		self.camasDisponibles(self.camasDisponibles() - paquete.cantidadPersonas())
		if (paquete.premium()) {
			self.reservarSpa()
		}
	}
	
	method reservarSpa() {
		spaDisponible = false
	}
	
}

object vehiculo {

	var property aireAcondicionado = false // si el VEHICULO tiene  aire acond.
	var property vtv = true // si el VEHICULO tiene la vtv
	var property asientosDisponibles = 10 // lugares disponibles del VEHICULO
	
	method sePuedeReservar(paquete) {
		// Un traslado se puede reservar si el vehiculo cuenta con 
		// lugares disponibles y tiene la verificacion tecnica al dia.
		// Si el paquete es premium, tambien tiene que cumplir que  
		// tenga aire Acondicionado
		return self.asientosDisponibles() >= paquete.cantidadPersonas() and self.vtv() 
											and (not paquete.premium() or self.aireAcondicionado())
	}
	
	method reservar(paquete) {
		self.asientosDisponibles(self.asientosDisponibles() - paquete.cantidadPersonas())
	}
}

object servicioCombinado {

	
	var property hotelEstadia = hotel
	var property vehiculoTraslado = vehiculo
	
	
	method sePuedeReservar(paquete) {
		return hotelEstadia.sePuedeReservar(paquete) and vehiculoTraslado.sePuedeReservar(paquete)
	}
	
	method reservar(paquete) {
		hotelEstadia.reservar(paquete)
		vehiculoTraslado.reservar(paquete)					
	}

}

