main() {
     imprime(1, 2, 3, 4, 5);
}

imprime(K, I, N, O, S) {
  if (N<0) {
      exit(0);
  }
  printf("numero = %d\n", N);
  imprime(N-1);
}
