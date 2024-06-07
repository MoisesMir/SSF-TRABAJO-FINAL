#include <WaspSensorEvent_v30.h>

float humd;
float value;

void setup() 
{
  // Turn on the USB and print a start message
  USB.ON();
  USB.println(F("Start program"));
  
}


void loop() 
{
  // Turn on the sensor board
  Events.ON();

  //Humidity
  humd = Events.getHumidity();

  USB.print("Humidity: ");
  USB.printFloat(humd, 1); 
  USB.println(F(" %")); 
  USB.println("-----------------------------");  

  USB.println(F("enter deep sleep"));
  PWR.deepSleep("00:00:00:10", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);
  USB.ON();
  USB.println(F("wake up\n"));
}



