int ldr_pin = A5;
int ldr_read = 0;
float vin = 5.00;
float valor_ADC = 0.00488758, r_ohms = 10000;

void setup() {
  Serial.begin(9600);
}

void loop() {
  if(isnan(ldr_read)){
    Serial.println("Erro ao ler o sensor");
  }
  else{
    ldr_read = analogRead(ldr_pin);
    float vout = valor_ADC * ldr_read;
    float res_ldr = (r_ohms * (vin - vout))/vout;
    float lux = 500/(res_ldr/1000);
    /*
     * Checando a voltagem
     * Quanto maior a incidência de luz, menor a resistência do sensor
     */
     if(ldr_read > 750){
        Serial.print(ldr_read);
        Serial.print(" Vout: ");
        Serial.print(vout);
        Serial.print(" R_ldr: ");
        Serial.print(res_ldr);
        Serial.print(" Lux: ");
        Serial.print(lux);
        Serial.println(" Claro");
     }
    else{
        Serial.print(ldr_read);
        Serial.print(" Vout: ");
        Serial.print(vout); //imprime na tela a tensão de saída
        Serial.print(" R_ldr: ");
        Serial.print(res_ldr); //Imprime na tela a resistência do ldr
        Serial.print(" Lux: ");
        Serial.print(lux); // Imprime na tela o valor do lux
        Serial.println(" Escuro");
    }
  }
  delay(2000);
}