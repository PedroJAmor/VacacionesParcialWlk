// Punto 1

class Lugar{
  const nombre

  method esRaro() = nombre.length() > 10

  method esDivertido() = self.tieneCantidadPar() && self.condicionLugarDivertido()

  method tieneCantidadPar() = nombre.length().even() //!(nombre.length() % 2)

  method condicionLugarDivertido()
  method esTranquilo() 
}

class Ciudad inherits Lugar{
  var property cantidadDeHabitantes
  var property atracciones
  var property decibeles

  override method condicionLugarDivertido() = self.tieneMuchasAtracciones() && self.tieneMuchosHabitantes()

  method tieneMuchasAtracciones() = atracciones.size() > 3
  method tieneMuchosHabitantes() = cantidadDeHabitantes > 100000

  override method esTranquilo() = decibeles < 20
}

class Pueblo inherits Lugar{
  const extension
  const anioFundacion
  const provincia
  const provinciasLitoral = ["Entre Rios", "Corrientes", "Misiones"]


  override method condicionLugarDivertido() = self.esDelLitoral() || self.esPuebloAntiguo()

  method esDelLitoral() = provinciasLitoral.contains(provincia)
  method esPuebloAntiguo() = anioFundacion < 1800

  override method esTranquilo() = provincia == "La Pampa"
}

class Balneario inherits Lugar{
  const metrosDePlaya
  var property marPeligroso 
  var property tienePeatonal 

  override method condicionLugarDivertido() = self.tieneMuchaPlaya() &&  marPeligroso

  method tieneMuchaPlaya() = metrosDePlaya > 300

  override method esTranquilo() = !tienePeatonal
}

//Punto 2
 
class Persona{

  var property presupuestoMaximo 
  var property preferencia

  method quiereIrA(lugar) = preferencia.quiereIrA(lugar) 
}

object tranquilidad {
  method quiereIrA(lugar) = lugar.esTranquilo()
}

object diversion {
  method quiereIrA(lugar) = lugar.esDivertido()
}

object lugarRaro {
  method quiereIrA(lugar) = lugar.esRaro()
}

class PreferenciaCombinada{
  var property preferencias =[]
  method quiereIrA(lugar) = preferencias.all{preferencia => preferencia.quiereIrA(lugar)}
}

//Punto 3


class Tour{
  const fechaSalida
  const cantidadDePersonas
  const lugares
  const montoPorPersona

  var property personasAnotadas = []

  method agregarPersona(persona){
    if(personasAnotadas.size() < cantidadDePersonas){
      if (self.leGusta(persona)){
        personasAnotadas.add(persona)
      } else{
        throw new UserException(message = "El viaje no cumple los requisitos de la persona")
      }
    } else{
      throw new UserException(message = "La lista está llena")
    }
  }

  method darDeBaja(persona) = personasAnotadas.remove(persona)

  method leGusta(persona) =  self.tienePlata(persona) && self.lugaresSonAdecuados(persona)

  method tienePlata(persona) = persona.presupuestoMaximo() < montoPorPersona
  method lugaresSonAdecuados(persona) = lugares.all{lugar => lugar.quiereIrA(Persona)}
}




class UserException inherits Exception{}