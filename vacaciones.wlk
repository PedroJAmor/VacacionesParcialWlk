// Punto 1

class Lugar{
  const nombre

  method nombreRaro() = nombre.length() > 10

  method esDivertido() = self.tieneCantidadPar() && self.condicionParticularDivertido()

  method tieneCantidadPar() = nombre.length().even()

  method condicionParticularDivertido()
  method esTranquilo() //no hace falta, pero no está mal
}

class Ciudad inherits Lugar{
  var property cantidadDeHabitantes
  var property atracciones
  var property decibeles

  override method condicionParticularDivertido() = self.tieneMuchasAtracciones() && self.tieneMuchosHabitantes()

  method tieneMuchasAtracciones() = atracciones.size() > 3
  method tieneMuchosHabitantes() = cantidadDeHabitantes > 100000

  override method esTranquilo() = decibeles < 20
}

class Pueblo inherits Lugar{
  //const extension
  const fechaFundacion
  const provincia
  const provinciasLitoral = ["Entre Rios", "Corrientes", "Misiones"]


  override method condicionParticularDivertido() = self.esDelLitoral() || self.esPuebloAntiguo()

  method esDelLitoral() = provinciasLitoral.contains(provincia)
  method esPuebloAntiguo() = fechaFundacion.year() < 1800

  override method esTranquilo() = provincia == "La Pampa"
}

class Balneario inherits Lugar{
  const metrosDePlaya
  var property marPeligroso 
  var property tienePeatonal 

  override method condicionParticularDivertido() = self.tieneMuchaPlaya() &&  marPeligroso

  method tieneMuchaPlaya() = metrosDePlaya > 300

  override method esTranquilo() = !tienePeatonal
}

//Punto 2
 
class Persona{

  var property presupuestoMaximo 
  var property preferencia

  method elige(lugar) = preferencia.prefiere(lugar) 

  method puedePagar(monto) = monto <= presupuestoMaximo
}

object tranquilidad {
  method prefiere(lugar) = lugar.esTranquilo()
}

object diversion {
  method prefiere(lugar) = lugar.esDivertido()
}

object lugarRaro {
  method prefiere(lugar) = lugar.nombreRaro()
}

class PreferenciaCombinada{
  var property preferencias =[]
  method prefiere(lugar) = preferencias.any{preferencia => preferencia.quiereIrA(lugar)}
}

//Punto 3


class Tour{
  const fechaSalida
  const integrantes = []
  const lugares
  const montoPorPersona
  const cantidadMaxima
  const listaDeEspera = []

  var property personasAnotadas = []

  method montoTotal() = montoPorPersona * self.cantidadDeIntegrantes()
  method confirmado() = self.tourCompleto()

  method agregarPersona(persona){
    self.validarPago(persona)
    self.validarPreferencia(persona)
    self.validarEspacio(persona)

    integrantes.add(persona)
  }

  method validarPago(persona) {
    if(!persona.puedePagar(montoPorPersona)) throw new DomainException(message = "El costo es mayor al presupuesto")
  }

  method validarPreferencia(persona){
    if(!self.eligeLugares(persona)) throw new DomainException(message = "La persona no elige los lugares")
  }

  method validarEspacio(persona) {
    if(self.tourCompleto()){
      throw new DomainException(message = "El tour está completo. Se añade a lista de espera")
      listaDeEspera.add(persona)
    } 
  }

  method darDeBaja(persona){
    integrantes.remove(persona)
    self.agregarPersonaLista()
  } 

  method agregarPersonaLista() {
    const nuevoIntegrante = listaDeEspera.first()
    listaDeEspera.remove(nuevoIntegrante)
    self.agregarPersona(nuevoIntegrante)
  }
  method eligeLugares(persona) = lugares.all{lugar => persona.elige(lugar)}
  method tourCompleto() = self.cantidadDeIntegrantes() == cantidadMaxima
  method cantidadDeIntegrantes() = integrantes.size()

  method esDeEsteAnio() = fechaSalida.year() == new Date().year()
}

//Punto 4

object reporte{
  const tours = []

  method toursPendientes() = tours.filter{tour => !tour.confirmado()}

  method montoTotalAnio() = self.toursEsteAnio().sum{tour => tour.montoTotal()}

  method toursEsteAnio() = tours.filter{tour => tour.esDeEsteAnio()}

}