#include <stdio.h>
#include <stdlib.h>
#include <math.h>


int main(){
    int num, vetbinaux[8], aux, somador = 0, conversor = 0;
    scanf("%d", &num);

    if(num >= 128){//Validação
        printf("entrada incorreta\n");
        exit(1);
    }

    for(int i = 0; i <= 7; i++){//Prenchendo o vetor binario de trás pra frente
        aux = num >> i;
        if(aux & 1){
            vetbinaux[i] = 1;
        }
        else{
            vetbinaux[i] = 0;
        }
    }

    for(int j = 0; j <= 7; j++){//Soma a quantidades de bits '1'
        if(vetbinaux[j] == 1){
            somador++;
        }
    }

    if((somador / 2) * 2 != somador){//Caso o contador seja ímpar, adiciona um bit '1' no bit mais significativo
        vetbinaux[7] = 1;
    }

    for(int z = 7; z >= 0; z--){//Converte de binario para decimal
        conversor += vetbinaux[z] * pow(2, z);
    }

    printf("bit-paridade: %d\n", vetbinaux[7]);
    printf("saida: %d\n", conversor);
    printf("\n");

return 0;
}