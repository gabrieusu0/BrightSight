const int PINO_SENSOR_LDR = A4; // Especificação da entrada analógica com o sensor
int valorLuminosidade; // "Variável" que armazena o valor obtido pelo sensor 

void setup() {
  Serial.begin(9600); // Sincronização do Arduino
}

void loop() { // Criação de um loop para sempre aparecer o dado obtido pelo sensor a cada dado obtido
  valorLuminosidade = analogRead(PINO_SENSOR_LDR); // Relaciona a contagem obtida pelo sensor com a variável valorLuminosidade

  Serial.println(valorLuminosidade); // Valor obtido pelo sensor na mensagem

  delay(1000); // Haverá uma demora de 2 segundos para que haja a obtenção do dado novamente (1000 = 1 segundo)
}
