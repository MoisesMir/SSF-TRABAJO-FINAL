#include <WaspSensorEvent_v30.h>
#include <WaspSD.h>

// Variables para almacenar las lecturas
float temp;
float humd;
float pres;
uint32_t light;

// Nombre del archivo en la tarjeta SD
const char* filename = "data.txt";

void setup() 
{
  // Encender el USB y mostrar un mensaje de inicio
  USB.ON();
  USB.println(F("Start program"));
  
  // Encender el sensor de eventos
  Events.ON();
  
  // Inicializar la tarjeta SD
  if (SD.ON() != 1) {
    USB.println(F("SD card not detected!"));
    return;
  }
  
  // Crear o abrir el archivo de datos
  SD.create(filename);
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

  ///////////////////////////////////////
  // 4. Guardar valores en la tarjeta SD
  ///////////////////////////////////////
  char buffer[128];
  sprintf(buffer, "Temperature: %.2f Celsius, Humidity: %.1f %%, Pressure: %.2f Pa, Light: %lu lux\n", temp, humd, pres, light);
  SD.append(filename, buffer);

  // Esperar un segundo antes de la siguiente lectura
  delay(1000);
}

