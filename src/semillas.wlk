// OPCIÓN HERENCIA

// planta.anioDeObtencion()
// planta.altura()
// planta.horasDeSolQueTolera()
// planta.esFuerte()
// planta.daSemillas()
// planta.espacio()

// planta.esIdeal(parcela)

// planta.seAsociaBienDentroDe(parcela) [Complica el polimorfismo entre parcelas]
// parcela.seAsociaBien(planta) [Como depende de la parcela, le voy a mandar el mensaje a ella]

class Planta {
	const property anioDeObtencion
	const property altura
	
	// Template method (tiene una parte general y otra particular)
	method esFuerte() = self.horasDeSolQueTolera() > 10
	method horasDeSolQueTolera()
	
	method daSemillas() = self.esFuerte() or self.condicionAlternativa()
	method condicionAlternativa()
	
	method espacio()
	// TODO: Revisar esta lógica
	method soportas(horasDeSol) = horasDeSol - 2 < self.horasDeSolQueTolera()
}

class Menta inherits Planta {
	override method horasDeSolQueTolera() = 6
	override method condicionAlternativa() = altura > 0.4
	override method espacio() = altura * 3
	method esIdeal(parcela) = parcela.superficie() > 6
}

class Hierbabuena inherits Menta {
	override method espacio() = super() * 2
}

class Quinoa inherits Planta {
	const property horasDeSolQueTolera
	override method condicionAlternativa() = anioDeObtencion < 2005
	override method espacio() = 0.5
	method esIdeal(parcela) = parcela.sonTodasBajas()
}

class Soja inherits Planta {
	override method horasDeSolQueTolera() = if (altura < 0.5) 6 else if (altura.between(0.5, 1)) 7 else 9
	override method condicionAlternativa() = anioDeObtencion > 2007 and altura > 1
	override method espacio() = altura / 2	
	method esIdeal(parcela) = parcela.horasDeSol() == self.horasDeSolQueTolera()
}

class SojaTransgenica inherits Soja {
	override method daSemillas() = false
	override method esIdeal(parcela) = parcela.sosMonocultivo()
}


class Parcela {
	const ancho
	const largo
	const property horasDeSol
	const plantas = []
	
	method superficie() = ancho * largo
	
	method cantidadMaximaQueSoporta() = if (ancho > largo) self.superficie() / 5 else self.superficie() / 3 + largo
	
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
		if (not planta.soportas(horasDeSol)) {
			self.error("Esta parcela te va a quemar la planta")
		} 
	}
	
	method estaLlena() = plantas.size() >= self.cantidadMaximaQueSoporta()
	
	method sonTodasBajas() = plantas.all({ planta => planta.altura() < 1.5 })
	
	method sosMonocultivo() = self.cantidadMaximaQueSoporta() == 1
	
	method cantidadDePlantas() = plantas.size()
	
	method porcentajeBienAsociado() = self.cantidadBienAsociadas() / self.cantidadDePlantas()
	
	method cantidadBienAsociadas() = 
		plantas.count({ planta => self.seAsociaBien(planta) })
	method seAsociaBien(panta)
}

class ParcelaEcologica inherits Parcela { 
	override method seAsociaBien(planta) = not self.tieneComplicaciones() and planta.esIdeal(self)
}

class ParcelaIndustrial inherits Parcela {
	override method seAsociaBien(planta) = self.cantidadDePlantas() <= 2 and planta.esFuerte()
}

object inta {
	const parcelas = [ ]
	
	method agregarParcela(parcela) { parcelas.add(parcela) } 
	
	method promedioDePlantas() = self.totalDePlantas() / self.cantidadDeParcelas()
	
	method totalDePlantas() = parcelas.sum({ parcela => parcela.cantidadDePlantas()})
	
	method cantidadDeParcelas() = parcelas.size()
	
	
	method parcelaMasAutosustentable() = 
		self.parcelasConMuchasPlantas().max({ parcela => parcela.porcentajeBienAsociado() })
	
	method parcelasConMuchasPlantas() =
		parcelas.filter({ parcela => parcela.cantidadDePlantas() > 4})
	
}


