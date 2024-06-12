/*
    ------ Waspmote Pro Code Example --------

    Explanation: This is the basic Code for Waspmote Pro

    Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L.
    http://www.libelium.com

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Put your libraries here (#include ...)

#include <WaspSensorEvent_v30.h>

// Variables para almacenar valores del sensor
float temp;
float humd;
float pres;


void setup()
{
  // put your setup code here, to run once:

   // Inicializa la comunicación USB para depuración
  USB.ON();
  USB.println(F("Start program"));

}


void loop()
{
  // put your main code here, to run repeatedly:

  ///////////////////////////////////////
  // 1. Leer los valores del sensor BME280
  ///////////////////////////////////////
  // Enciende la placa de sensores
  Events.ON();
  // Leer la temperatura
  temp = Events.getTemperature();
  // Leer la humedad
  humd = Events.getHumidity();
  // Leer la presión
  pres = Events.getPressure();

  ///////////////////////////////////////
  // 2. Imprimir los valores del sensor BME280
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
  USB.println("-----------------------------");  

  ///////////////////////////////////////
  // 3. Imprimir mensajes según la temperatura
  ///////////////////////////////////////
  if (temp > 30.0) {
    USB.println(F("Temperatura alta! Enciende el aire acondicionado."));
  } 
  else if (temp < 15.0) {
    USB.println(F("Temperatura baja! Enciende la calefacción."));
  }

  ///////////////////////////////////////
  // 4. Entrar en modo de sueño profundo
  ///////////////////////////////////////
  USB.println(F("enter deep sleep"));
  PWR.deepSleep("00:00:00:10", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);
  USB.ON();
  USB.println(F("wake up\n"));

}
