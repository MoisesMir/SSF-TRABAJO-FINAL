#include <WaspSensorEvent_v30.h>

// Variables para almacenar las lecturas
float temp;
float humd;
float pres;
uint32_t light;

// Crear el objeto para el sensor de luz

void setup() 
{
  // Encender el USB y mostrar un mensaje de inicio
  USB.ON();
  USB.println(F("Start program"));
  
  // Encender el sensor de eventos
  Events.ON();

  // Encender el sensor de luz
}

void loop() 
{
  ///////////////////////////////////////
  // 1. Leer valores del BME280
  ///////////////////////////////////////
  // Temperatura
  temp = Events.getTemperature();
  // Humedad
  humd = Events.getHumidity();
  // Presión
  pres = Events.getPressure();

  ///////////////////////////////////////
  // 2. Leer valores de luz
  ///////////////////////////////////////
  light = Events.getLuxes(INDOOR);

  ///////////////////////////////////////
  // 3. Imprimir valores del BME280 y de luz
  ///////////////////////////////////////
  USB.println("-----------------------------");
  USB.print("Temperature: ");
  USB.printFloat(temp, 2);
  USB.println(F(" Celsius"));
  USB.print("Humidity: ");
  USB.printFloat(humd, 1); 
  USB.println(F(" %")); 
  USB.print("Pressure: ");
  USB.printFloat(pres, 2); 
  USB.println(F(" Pa")); 
  USB.print("Light: ");
  USB.print(light); 
  USB.println(F(" lux"));
  USB.println("-----------------------------");

  // Esperar un segundo antes de la siguiente lectura
  delay(1000);
}



