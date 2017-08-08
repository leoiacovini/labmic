
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
  char *dois = "2";
  print_uart0(dois);
}

void imprime3() {
  char *tres = "3";
  while(1) {
    delay(10000000/15);

    print_uart0(tres);
  }
}

void imprime4() {
  char *nusp = "8";
  while(1) {
    delay(10000000/15);
    print_uart0("8");
    print_uart0("0");
    print_uart0("4");
    print_uart0("1");
    print_uart0("8");
    print_uart0("6");
    print_uart0("3");
  }
}

int c_entry() {

  char *um = "1";
  print_uart0(um);
  end_irq();
  return 0;
}
