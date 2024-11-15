// Punto 1

class Lugar{
  const nombre

  method esDivertido() = self.tieneCantidadPar() && self.condicionLugarDivertido()

  method tieneCantidadPar() = (nombre.lenght() % 2) == 0 //!(nombre.length() % 2)

  method condicionLugarDivertido() 
}

class Ciudad inherits Lugar{
  var property cantidadDeHabitantes
  var property atracciones
  var property decibeles

  override method condicionLugarDivertido() = self.tieneMuchasAtracciones() && self.tieneMuchosHabitantes()

  method tieneMuchasAtracciones() = atracciones.size() > 3
  method tieneMuchosHabitantes() = cantidadDeHabitantes > 100000
}

class Pueblo inherits Lugar{
  const extension
  const anioFundacion
  const provincia
  const provinciasLitoral = ["Entre Rios", "Corrientes", "Misiones"]


  override method condicionLugarDivertido() = self.esDelLitoral() || self.esPuebloAntiguo()

  method esDelLitoral() = provinciasLitoral.contains(provincia)
  method esPuebloAntiguo() = anioFundacion < 1800 
}

class Balneario inherits Lugar{
  const metrosDePlaya
  var property marPeligroso 
  var property tienePeatonal 

  override method condicionLugarDivertido() = self.tieneMuchaPlaya() &&  marPeligroso

  method tieneMuchaPlaya() = metrosDePlaya > 300
}











