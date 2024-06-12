const uint8_t SLEEP_TIME_MINUTES = 5; // Define the sleep time in minutes

// Enter deep sleep mode
USB.println(F("Entering deep sleep mode"));
PWR.deepSleep("00:00:00:00", SLEEP_TIME_MINUTES, RTC_OFFSET, RTC_ALM1_MODE2, SENS_OFF);

USB.println(F("Waking up from deep sleep"));
