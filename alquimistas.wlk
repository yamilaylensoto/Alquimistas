//.....................................................................................................................ALQUIMISTA
object alquimista {
		var itemsDeCombate=[]
		var itemsDeRecoleccion=[]
 	method cantidadItemsDeCombate(){
 		return itemsDeCombate.size()
 	}
 	method cantidadItemsDeCombateEfectivos(){
 		return itemsDeCombate.filter({idC => idC.esEfectivo()}).size()
 	}
 	method tieneCriterio(){
 		return self.cantidadItemsDeCombate()/2 <= self.cantidadItemsDeCombateEfectivos()
 	}	
 	method cantItemsDeRecoleccion (){
 		return itemsDeRecoleccion.size()
 	}
 	method buenExplorador(){
 		return self.cantItemsDeRecoleccion() >= 3
 	}
 	method capacidadItemsDeCombate(){
 		return itemsDeCombate.map{item => item.capacidad()}
 	}
 	method capacidadOfensiva(){
 		return self.capacidadItemsDeCombate().sum()
 	}
 	method calidadItemsCombate(){
 		return itemsDeCombate.map{item => item.calidad()}
 	}
 	method calidadPromedioItemsDeCombate(){
 		return self.calidadItemsCombate().sum() / self.cantidadItemsDeCombate()
 	}
 	method todosItemsDeCombateEfectivos(){
 		return itemsDeCombate.all{item => item.esEfectivo()}
 	}
 	method esProfesional(){
 		return self.calidadPromedioItemsDeCombate() > 50 && self.todosItemsDeCombateEfectivos() && self.buenExplorador()
 	}
//...........................................................................................................................test
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
	method calidad (){
		return self.calidadMateriales().min()
	}
	method calidadMateriales(){
		return materiales.map{material => material.calidad()}
	}
//...........................................................................................................................test
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
//...........................................................................................................................test
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
//...........................................................................................................................test
	method agregarMaterial(unMaterial){
		materiales.add(unMaterial)
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