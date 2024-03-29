//.....................................................................................................................ALQUIMISTA
object alquimista {
		var itemsDeCombate=[]
		var itemsDeRecoleccion=[]
//---Punto 1
 	method cantidadItemsDeCombate(){
 		return itemsDeCombate.size()
 	}
 	method cantidadItemsDeCombateEfectivos(){
 		return itemsDeCombate.filter({idC => idC.esEfectivo()}).size()
 	}
 	method tieneCriterio(){
 		return self.cantidadItemsDeCombate()/2 <= self.cantidadItemsDeCombateEfectivos()
 	}	
//---Punto 2
 	method cantItemsDeRecoleccion (){
 		return itemsDeRecoleccion.size()
 	}
 	method buenExplorador(){
 		return self.cantItemsDeRecoleccion() >= 3
 	}
//---Punto 3
 	method capacidadItemsDeCombate(){
 		return itemsDeCombate.map{item => item.capacidad()}
 	}
 	method capacidadOfensiva(){
 		return self.capacidadItemsDeCombate().sum()
 	}
//---Punto 4
 	method calidadItemsCombate(){
 		return itemsDeCombate.map{item => item.calidad()}.sum()
 	}
 	method calidadMaterialesRecoleccion(){
 		return itemsDeRecoleccion.map{item => item.calidad()}.sum()
 	}
 	method calidadItemsDeRecoleccion(){
 		return 30 + self.calidadMaterialesRecoleccion() / 10
 	}
 	
  //---Para items de combate y recoleccion
 	method cantidadItemsTotal(){
 		return self.cantidadItemsDeCombate() + self.cantItemsDeRecoleccion()
 	}
 	method calidadItemsTotal(){
 		return self.calidadItemsDeRecoleccion() + self.calidadItemsCombate()
 	}
 	method calidadPromedioItems(){
 		if (self.cantidadItemsTotal() != 0) return self.calidadItemsTotal() / self.cantidadItemsTotal()
 		return 0
 	}
 	
  //---Items de combate efectivos
 	method todosItemsDeCombateEfectivos(){
 		return itemsDeCombate.all{item => item.esEfectivo()}
 	}
 	
  //---Es profesional
 	method esProfesional(){
 		return self.calidadPromedioItems() > 50 && self.todosItemsDeCombateEfectivos() && self.buenExplorador()
 	}
 	
 	
//---test
	method agregarItem(unItem){
		itemsDeCombate.add(unItem)
	}
	method itemsDeCombate(){
		return itemsDeCombate
	}
	method agregarItemRecoleccion(unItem){
		itemsDeRecoleccion.add(unItem)
	}
}



//..........................................................................................................................BOMBA
object bomba{
		var materiales=[]
		var danio = 0	
	method esEfectivo(){
		return danio > 100
	}
	method capacidad(){
		return danio/2
	}
	method materiales(){
		return materiales
	}
	method calidadMateriales(){
		return materiales.map{material => material.calidad()}
	}
	method calidad (){
		if (materiales.size() == 0) return 0
		return self.calidadMateriales().min()
	}
	
//---test
	method agregarMaterial(unMaterial){
		materiales.add(unMaterial)
	}
	method cambiarDanio(nuevoDanio){
		danio = nuevoDanio
	}
}



//.........................................................................................................................POCION
object pocion{ 
		var materiales= []
		var poderCurativo = 0
	method esEfectivo(){
		return poderCurativo > 50  && self.tieneMaterialMistico()
	}
	method materialesMisticos(){
		return materiales.filter{material => material.esMistico()}
	}
	method cantMaterialesMisticos(){
		return self.materialesMisticos().size()
	}
	method tieneMaterialMistico(){
		return self.cantMaterialesMisticos() != 0
	}
	method primerMaterialMistico(){
		return self.materialesMisticos().head()
	}
	method primerMaterial(){
		return materiales.head()
	}
	method puntosExtras(){
		return 10 * self.cantMaterialesMisticos()
	}
	method capacidad(){
		return poderCurativo + self.puntosExtras()
	}
	method primerosMateriales(){
		if (self.tieneMaterialMistico()) return self.primerMaterialMistico()
		else return self.primerMaterial()
	}
	method calidad(){
		return self.primerosMateriales().calidad()
	}
	
//---test
	method agregarMaterial(unMaterial){
		materiales.add(unMaterial)
	}
	method cambiarPoderCurativo(nuevoPoder){
		poderCurativo = nuevoPoder
	}
}



//....................................................................................................................DEBILITADOR
object debilitador{
		var materiales=[]
		var potencia = 0
		var max1 = 0
		var max2 = 0
		var listaCalidades
	method esEfectivo(){
		return potencia > 0 && self.noTieneMaterialMistico()
	}
	method materialesMisticos(){
		return materiales.filter{material => material.esMistico()}
	}
	method cantMaterialesMisticos(){
		return self.materialesMisticos().size()
	}
	method noTieneMaterialMistico(){
		return self.cantMaterialesMisticos() == 0
	}
	method cantidadMateriales(){
		return materiales.size()
	}
	method capacidad(){
		if (self.noTieneMaterialMistico())  return 5
		else return 12 * self.cantidadMateriales()
	}
	method calidadMateriales(){
		return materiales.map{material => material.calidad()}
	}
	method potencia(){
		return potencia
	}
	
//PUNTO 4
	method calDeItemsMayorCalidad(){
		self.primerMaximo()
		self.segundoMaximo()
		return [max1, max2]	
	}
	method primerMaximo(){
		listaCalidades = self.calidadMateriales()
		if (listaCalidades.size() != 0) max1 = listaCalidades.max()
	}
	method borrarPrimerMaximo(){
		self.primerMaximo()
		listaCalidades.remove(max1)
	}
	method segundoMaximo(){
		self.borrarPrimerMaximo()
		if (listaCalidades.size() != 0) max2 = listaCalidades.max()
	}
	method calidad(){
		return self.calDeItemsMayorCalidad().sum() / 2			//...............................................Debe dar 12.5
	}
	
//---test
	method agregarMaterial(unMaterial){
		materiales.add(unMaterial)
	}
	method listaCalidades(){
		return listaCalidades
	}
}


//.....................................................................................................................AUXILIARES
object unMaterialMistico{
		var calidad = 10
	method esMistico(){
		return true
	}
	method calidad(){
		return calidad
	}
}

object unMaterial{
		var calidad = 15
	method esMistico(){
		return false
	}
	method calidad(){
		return calidad
	}
}
object materialAltaCalidad{
		var calidad = 100
	method calidad(){
		return calidad
	}
}
object materialCalidad200{
		var calidad = 200
	method calidad(){
		return calidad
	}
}