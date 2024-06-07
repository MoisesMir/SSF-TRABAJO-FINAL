#include <WaspSensorEvent_v30.h>
float pres;
float value;

void setup()
{
  // Turn on the USB and print a start message
  USB.ON();
  USB.println(F("Start program"));

}



void loop()
{

  Events.ON();
  //Pressure
  pres = Events.getPressure();
/
  USB.println("-----------------------------");
  USB.print("Pressure: ");
  USB.printFloat(pres, 2);
  USB.println(F(" Pa"));
  USB.println("-----------------------------");


  USB.println(F("enter deep sleep"));
  PWR.deepSleep("00:00:00:10", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);
  USB.ON();
  USB.println(F("wake up\n"));
}


