#include <WaspPWR.h>
#include <WaspRTC.h>

void setup() 
{
  // Encender el USB y mostrar un mensaje de inicio
  USB.ON();
  USB.println(F("Start program"));

  // Inicializar el RTC (Reloj en Tiempo Real)
  RTC.ON();

  // Mostrar mensaje para indicar que el RTC está encendido
  USB.println(F("RTC inicializado"));

  // Esperar un momento para que el mensaje se envíe antes de entrar en suspensión profunda
  delay(1000);
}

void loop() 
{
  // Mostrar mensaje antes de entrar en suspensión profunda
  USB.println(F("A dormiiiiirrr..."));

  // Apagar el USB antes de entrar en suspensión profunda
  USB.OFF();

  // Entrar en modo de suspensión profunda durante 30 segundos
  PWR.deepSleep("00:00:30", RTC_OFFSET, RTC_ALM1_MODE1, ALL_OFF);

  // Encender el USB al despertar de la suspensión profunda
  USB.ON();

  // Mostrar mensaje después de despertar de la suspensión profunda
  USB.println(F("He despertado"));

  // Esperar un momento antes de repetir el ciclo
  delay(1000);
}
1

