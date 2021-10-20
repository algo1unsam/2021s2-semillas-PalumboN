// OPCIÓN HERENCIA

// planta.anioDeObtencion()
// planta.altura()
// planta.horasDeSolQueTolera()
// planta.esFuerte()
// planta.daSemillas()
// planta.espacio()
class Planta {
	const property anioDeObtencion
	const property altura
	
	// Template method (tiene una parte general y otra particular)
	method esFuerte() = self.horasDeSolQueTolera() > 10
	method horasDeSolQueTolera()
	
	method daSemillas() = self.esFuerte() or self.condicionAlternativa()
	method condicionAlternativa()
	
	method espacio()
	
	method soportas(horasDeSol) = self.horasDeSolQueTolera() >= horasDeSol + 2
}

class Menta inherits Planta {
	override method horasDeSolQueTolera() = 6
	override method condicionAlternativa() = altura > 0.4
	override method espacio() = altura * 3
}

class Hierbabuena inherits Menta {
	override method espacio() = super() * 2
}

class Soja inherits Planta {
	override method horasDeSolQueTolera() = if (altura < 0.5) 6 else if (altura.between(0.5, 1)) 7 else 9
	override method condicionAlternativa() = anioDeObtencion > 2007 and altura > 1
	override method espacio() = altura / 2
}

class SojaTransgenica inherits Soja {
	override method daSemillas() = false
}

class Quinoa inherits Planta {
	const property horasDeSolQueTolera
	override method condicionAlternativa() = anioDeObtencion < 2005
	override method espacio() = 0.5
}


class Parcela {
	const ancho
	const largo
	const horasDeSol
	const plantas = []
	
	method superficie() = ancho * largo
	
	method cantidadMaxima() = if (ancho > largo) self.superficie() / 5 else self.superficie() / 3 + largo
	
	method tieneComplicaciones() = 
		plantas.any({ unaPlanta => unaPlanta.horasDeSolQueTolera() < horasDeSol })
		
	method plantar(planta) {
		self.validarNuevaPlanta()
		self.validarHorasDeSol(planta)
		plantas.add(planta)
	}
	
	method validarNuevaPlanta() {
		if (self.estaLlena()) {
			self.error("La parcella está llena")
		} 
	}
	
	method validarHorasDeSol(planta) {
		if (planta.soportas(horasDeSol)) {
			self.error("Esta parcela te va a quemar la planta")
		} 
	}
	
	method estaLlena() = plantas.size() >= self.cantidadMaxima()
}

