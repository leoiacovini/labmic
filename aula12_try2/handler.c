
volatile unsigned int * const UART0DR = (unsigned int *) 0x101f1000;
volatile unsigned int * const TIMER0X = (unsigned int *) 0x101E200c;

void print_uart0(const char *s) {
  while(*s != '\0') {
    *UART0DR = (unsigned int)(*s);
    s++;
  }
}

void end_irq() {
  *TIMER0X = (unsigned int) 0;
}
void delay(long long int a) {
  long long int b = a;
  while(b > 0) {
    b--;
  }
}

void imprime2() {
  delay(10000000/15);
  print_uart0("2");
}

void imprime3() {
  delay(10000000/15);
  print_uart0("3");
}

int c_entry() {
  print_uart0("1");
  end_irq();
  return 0;
}
