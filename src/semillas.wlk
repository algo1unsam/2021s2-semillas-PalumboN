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
}

class Menta inherits Planta {
	override method horasDeSolQueTolera() = 6
	override method condicionAlternativa() = altura > 0.4
	override method espacio() = altura * 3
}

class Soja inherits Planta {
	override method horasDeSolQueTolera() = if (altura < 0.5) 6 else if (altura.between(0.5, 1)) 7 else 9
	override method condicionAlternativa() = anioDeObtencion > 2007 and altura > 1
	override method espacio() = altura / 2
}

class Quinoa inherits Planta {
	const property horasDeSolQueTolera
	override method condicionAlternativa() = anioDeObtencion < 2005
	override method espacio() = 0.5
}