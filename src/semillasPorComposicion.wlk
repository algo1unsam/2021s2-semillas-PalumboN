class Planta {

	const especie
	const property anioDeObtencion
	const property altura

	// Template method (tiene una parte general y otra particular)
	method esFuerte() = self.horasDeSolQueTolera() > 10

	method horasDeSolQueTolera() = especie.horasDeSolQueTolera(self)

	method daSemillas() = self.esFuerte() or self.condicionAlternativa()

	method condicionAlternativa() = especie.condicionAlternativa(self)

	method espacio() = especie.espacio(self)

}

object menta {

	method horasDeSolQueTolera(planta) = 6

	method condicionAlternativa(planta) = planta.altura() > 0.4

	method espacio(planta) = planta.altura() * 3

}

object soja {

	method horasDeSolQueTolera(planta) = if (planta.altura() < 0.5) 6 else if (planta.altura().between(0.5, 1)) 7 else 9

	method condicionAlternativa(planta) = planta.anioDeObtencion() > 2007 and planta.altura() > 1

	method espacio(planta) = planta.altura() / 2

}

class Quinoa {

	const property horasDeSolQueTolera

	method horasDeSolQueTolera(planta) = horasDeSolQueTolera

	method condicionAlternativa(planta) = planta.anioDeObtencion() < 2005

	method espacio(planta) = 0.5

}

