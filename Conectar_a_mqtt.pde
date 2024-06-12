/*
    ------ Combined WiFi and MQTT Example --------

    Explanation: This example shows how to configure the WiFi module
    to join a specific Access Point and then publish data to an MQTT topic.

    Copyright (C) 2021 Libelium Comunicaciones Distribuidas S.L.
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

    Version:           3.0
    Implementation:    Yuri Carmona, Luis Miguel Martí
*/

#include <WaspWIFI_PRO_V3.h>

// choose socket (SELECT USER'S SOCKET)
uint8_t socket = SOCKET0;

// WiFi AP settings (CHANGE TO USER'S AP)
char SSID[] = "AndroidJSM";
char PASSW[] = "alumno2223";

// MQTT server settings (CHANGE TO USER'S MQTT SERVER)
char MQTT_SERVER[] = "192.168.30.114";
uint16_t MQTT_PORT = 8123;

// define variables
uint8_t error;
uint8_t status;
unsigned long previous;

void setup() {
  USB.println(F("Start program"));

  //////////////////////////////////////////////////
  // 1. Switch ON the WiFi module
  //////////////////////////////////////////////////
  error = WIFI_PRO_V3.ON(socket);

  if (error == 0) {
    USB.println(F("1. WiFi switched ON"));
  } else {
    USB.println(F("1. WiFi did not initialize correctly"));
  }

  //////////////////////////////////////////////////
  // 2. Reset to default values
  //////////////////////////////////////////////////
  error = WIFI_PRO_V3.resetValues();

  if (error == 0) {
    USB.println(F("2. WiFi reset to default"));
  } else {
    USB.print(F("2. WiFi reset to default error: "));
    USB.println(error, DEC);
  }

  //////////////////////////////////////////////////
  // 3. Configure mode (Station or AP)
  //////////////////////////////////////////////////
  error = WIFI_PRO_V3.configureMode(WaspWIFI_v3::MODE_STATION);

  if (error == 0) {
    USB.println(F("3. WiFi configured OK"));
  } else {
    USB.print(F("3. WiFi configured error: "));
    USB.println(error, DEC);
  }

  // get current time
  previous = millis();

  //////////////////////////////////////////////////
  // 4. Configure SSID and password and autoconnect
  //////////////////////////////////////////////////
  error = WIFI_PRO_V3.configureStation(SSID, PASSW, WaspWIFI_v3::AUTOCONNECT_ENABLED);

  if (error == 0) {
    USB.println(F("4. WiFi configured SSID OK"));
  } else {
    USB.print(F("4. WiFi configured SSID error: "));
    USB.println(error, DEC);
  }

  if (error == 0) {
    USB.println(F("5. WiFi connected to AP OK"));

    USB.print(F("SSID: "));
    USB.println(WIFI_PRO_V3._essid);

    USB.print(F("Channel: "));
    USB.println(WIFI_PRO_V3._channel, DEC);

    USB.print(F("Signal strength: "));
    USB.print(WIFI_PRO_V3._power, DEC);
    USB.println("dB");

    USB.print(F("IP address: "));
    USB.println(WIFI_PRO_V3._ip);

    USB.print(F("GW address: "));
    USB.println(WIFI_PRO_V3._gw);

    USB.print(F("Netmask address: "));
    USB.println(WIFI_PRO_V3._netmask);

    WIFI_PRO_V3.getMAC();

    USB.print(F("MAC address: "));
    USB.println(WIFI_PRO_V3._mac);
  } else {
    USB.print(F("5. WiFi connect error: "));
    USB.println(error, DEC);

    USB.print(F("Disconnect status: "));
    USB.println(WIFI_PRO_V3._status, DEC);

    USB.print(F("Disconnect reason: "));
    USB.println(WIFI_PRO_V3._reason, DEC);
  }

  //////////////////////////////////////////////////
  // 6. Configure MQTT connection
  //////////////////////////////////////////////////
  error = WIFI_PRO_V3.mqttConfiguration(MQTT_SERVER, "", MQTT_PORT, WaspWIFI_v3::MQTT_TLS_DISABLED);

  if (error == 0) {
    USB.println(F("6. MQTT connection configured"));
  } else {
    USB.print(F("6. MQTT connection configured ERROR"));
    USB.println(error, DEC);
  }
}

void loop() {
  // Check if module is connected
  if (WIFI_PRO_V3.isConnected() == true) {
    USB.print(F("WiFi is connected OK"));
    USB.print(F(" Time(ms):"));
    USB.println(millis() - previous);

    //////////////////////////////////////////////////
    // Publish data to MQTT topic
    //////////////////////////////////////////////////
    error = WIFI_PRO_V3.mqttPublishTopic("prueba", WaspWIFI_v3::QOS_1, WaspWIFI_v3::RETAINED, "Temp:17");

    // check response
    if (error == 0) {
      USB.println(F("Publish topic done!"));
    } else {
      USB.println(F("Error publishing topic!"));
    }

    //////////////////////////////////////////////////
    // Switch OFF
    //////////////////////////////////////////////////
    WIFI_PRO_V3.OFF(socket);

    USB.println(F("\n*** Program stops ***"));
    while (1) {}
  } else {
    USB.print(F("WiFi is connected ERROR"));
    USB.print(F(" Time(ms):"));
    USB.println(millis() - previous);
  }

  delay(10000);
}


