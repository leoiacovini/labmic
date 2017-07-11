#include <stdlib.h>
#include <stdio.h>

#include "segment.h"
// Mapemanto do microcontrolador


int main(void) {

	// inicalização
	*IOPMOD 	|= SEG_MASK;
	*IOPDATA 	|= SEG_MASK;

	imprime(0x7);

  return 0;
}
