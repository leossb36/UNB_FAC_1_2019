# include <stdio.h> 
# include <math.h> 
  

void primeFactors(int n) 
{ 
    // Mostrar todos os 2 que divdem n
    while (n%2 == 0) 
    { 
        printf("%d ", 2); 
        n = n/2; 
    } 
  
    // n tem que ser impar agora, entao podemos pular 1 elemento  
    for (int i = 3; i <= sqrt(n); i = i+2) 
    { 
        // enquanto i divide n, printa 1 e divide n 
        while (n%i == 0) 
        { 
            printf("%d ", i); 
            n = n/i; 
        } 
    } 
  
    // condição serve caso n restante seja um numero primo maior que 2
    if (n > 2) 
        printf ("%d ", n); 
} 
  
// main padrãozinha
int main() 
{ 
    int n;
    scanf("%d", &n);
    primeFactors(n); 
    return 0; 
} 