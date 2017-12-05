
//COMPILAR :: gcc -c *.c && gcc aes_software.c -o teste && teste.exe

#include <string.h>
#include <stdio.h>
//#include "alt_types.h"
//#include "system.h"
//#include "altera_avalon_performance_counter.h" /*Use to measure code performance*/

#define INPUTFROMMIX (char *) 0x21060
#define OUTPUTTOMIX (char *) 0x21070
#define FLAG_IN (int *) 0x21050
#define FLAG_OUT (int *) 0x21040

#define N_colunas 4 // numeros de colunas no estado
int N_rodadas = 0; // numero de rodadas feitas pelo algoritmo
int N_chave = 0; // numero de palavras de 32 na chave
int f;
int cl;


// texto_crip - eh a matriz que contem o texto para ser criptografado
// chave_crip - eh a matriz que contem a chave para a encriptacao
// estados_parciais - eh matriz que contem os resultados intermediarios durante a criptografia
unsigned char mandando, texto_crip[16], saida_crip[16], estados_parciais[4][4];

unsigned char chaves_rodada[240]; // eh a matriz que armazena as chaves das rodadas

unsigned char chave[32], teste; // // eh a chave de entrada

// ainda nao sei como exatamente eh montada
int Rcon[255] = {
	0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a,
	0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39,
	0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a,
	0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8,
	0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef,
	0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc,
	0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b,
	0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3,
	0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94,
	0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
	0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63, 0xc6, 0x97, 0x35,
	0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd, 0x61, 0xc2, 0x9f,
	0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb, 0x8d, 0x01, 0x02, 0x04,
	0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36, 0x6c, 0xd8, 0xab, 0x4d, 0x9a, 0x2f, 0x5e, 0xbc, 0x63,
	0xc6, 0x97, 0x35, 0x6a, 0xd4, 0xb3, 0x7d, 0xfa, 0xef, 0xc5, 0x91, 0x39, 0x72, 0xe4, 0xd3, 0xbd,
	0x61, 0xc2, 0x9f, 0x25, 0x4a, 0x94, 0x33, 0x66, 0xcc, 0x83, 0x1d, 0x3a, 0x74, 0xe8, 0xcb  };

// funcao para pegar os valores de SBox
int pegar_valor_sbox(int num)
{
	int sbox[256] =   {
	//0     1    2      3     4    5     6     7      8    9     A      B    C     D     E     F
	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76, //0
	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0, //1
	0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15, //2
	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75, //3
	0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84, //4
	0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf, //5
	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8, //6
	0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2, //7
	0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73, //8
	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb, //9
	0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79, //A
	0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08, //B
	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a, //C
	0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e, //D
	0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf, //E
	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16 }; //F
	return sbox[num];
}

// funcao para realizar a extensao da chave
void chave_expansao()
{
	int i,j;
	unsigned char temp[4], c;

	// a primeira chave de rodada eh a propria chave
	for(i = 0 ; i < N_chave ; i++)
	{
		chaves_rodada[i*4] = chave[i*4];
		chaves_rodada[i*4+1] = chave[i*4+1];
		chaves_rodada[i*4+2] = chave[i*4+2];
		chaves_rodada[i*4+3] = chave[i*4+3];
	}

	// todas as outras chaves de rodada sao encontradas a partir da chave de rodada anterior
	while (i < (N_colunas * (N_rodadas + 1)))
	{
					for(j = 0 ; j < 4 ; j++)
					{
						temp[j] = 	chaves_rodada[(i-1) * 4 + j];
					}
					if (i % N_chave == 0)
					{
						// aqui roda os bytes uma vez pra esquerda, assim [a0,a1,a2,a3] fica [a1,a2,a3,a0]
						{
							c = temp[0];
							temp[0] = temp[1];
							temp[1] = temp[2];
							temp[2] = temp[3];
							temp[3] = c;
						}

					   // aqui aplicamos o sbox nos bytes
						{
							temp[0] = pegar_valor_sbox(temp[0]);
							temp[1] = pegar_valor_sbox(temp[1]);
							temp[2] = pegar_valor_sbox(temp[2]);
							temp[3] = pegar_valor_sbox(temp[3]);
						}

						temp[0] =  temp[0] ^ Rcon[i/N_chave];
					}
					else if (N_chave > 6 && i % N_chave == 4)
					{
						{
							temp[0] = pegar_valor_sbox(temp[0]);
							temp[1] = pegar_valor_sbox(temp[1]);
							temp[2] = pegar_valor_sbox(temp[2]);
							temp[3] = pegar_valor_sbox(temp[3]);
						}
					}

					chaves_rodada[i*4+0] = 	chaves_rodada[(i-N_chave)*4+0] ^ temp[0];
					chaves_rodada[i*4+1] = 	chaves_rodada[(i-N_chave)*4+1] ^ temp[1];
					chaves_rodada[i*4+2] = 	chaves_rodada[(i-N_chave)*4+2] ^ temp[2];
					chaves_rodada[i*4+3] = 	chaves_rodada[(i-N_chave)*4+3] ^ temp[3];
					i++;
	}
}

// funcao que adiciona a chave da rodada para o estado correto
void AddRoundKey(int rodada)
{
	int i,j;
	for(i = 0 ; i < 4 ; i++)
	{
		for(j = 0 ; j < 4 ; j++)
		{
			estados_parciais[j][i] ^= chaves_rodada[rodada * N_colunas * 4 + i * N_colunas + j];
		}
	}
}

// funcao SubBytes substitui os valores na matriz de estado com valores do sbox
void SubBytes()
{
	int i,j;
	for(i = 0 ; i < 4 ; i++)
	{
		for(j = 0 ; j < 4 ; j++)
		{
			estados_parciais[i][j] = pegar_valor_sbox(estados_parciais[i][j]);

		}
	}
}

// funcao ShiftRows desloca as posicoes no estado para a esquerda
void ShiftRows()
{
	unsigned char temp;

	temp = estados_parciais[1][0];
	estados_parciais[1][0] = estados_parciais[1][1];
	estados_parciais[1][1] = estados_parciais[1][2];
	estados_parciais[1][2] = estados_parciais[1][3];
	estados_parciais[1][3] = temp;

	temp = estados_parciais[2][0];
	estados_parciais[2][0] = estados_parciais[2][2];
	estados_parciais[2][2] = temp;

	temp = estados_parciais[2][1];
	estados_parciais[2][1] = estados_parciais[2][3];
	estados_parciais[2][3] = temp;

	temp = estados_parciais[3][0];
	estados_parciais[3][0] = estados_parciais[3][3];
	estados_parciais[3][3] = estados_parciais[3][2];
	estados_parciais[3][2] = estados_parciais[3][1];
	estados_parciais[3][1] = temp;
}

#define xtime(x)   ((x<<1) ^ (((x>>7) & 1) * 0x1b)) // ainda nao sei bem pra que serve

// funcao MixColumns mistura as colunas da matriz de estado
void MixColumns()
{
	int i;
	unsigned char tmp,tm,t;

	for(i = 0 ; i < 4 ; i++)
	{
		t = estados_parciais[0][i];
		tmp = estados_parciais[0][i] ^ estados_parciais[1][i] ^ estados_parciais[2][i] ^ estados_parciais[3][i] ;
		tm = estados_parciais[0][i] ^ estados_parciais[1][i] ;
		tm = xtime(tm);
		estados_parciais[0][i] ^= tm ^ tmp ;
		tm = estados_parciais[1][i] ^ estados_parciais[2][i] ;
		tm = xtime(tm);
		estados_parciais[1][i] ^= tm ^ tmp ;
		tm = estados_parciais[2][i] ^ estados_parciais[3][i] ;
		tm = xtime(tm);
		estados_parciais[2][i] ^= tm ^ tmp ;
		tm = estados_parciais[3][i] ^ t ;
		tm = xtime(tm);
		estados_parciais[3][i] ^= tm ^ tmp ;
	}
}

// funcao que criptografa o texto
void crip_texto()
{
	int i,j,rodada = 0;

	// aqui copia o texto de entrada para a matriz de estados parciais
	for(i = 0 ; i < 4 ; i++)
	{
		for(j = 0 ; j < 4 ; j++)
		{
			estados_parciais[j][i] = texto_crip[i*4 + j];
		}
	}

	// aqui adiciona a primeira chave de rodada para o estado antes de iniciar as rodadas
	AddRoundKey(0);
	mostrarEstado(1);

	// aqui comeca a execucao das rodadas
	for(rodada = 1 ; rodada < N_rodadas ; rodada++)
	{
		SubBytes();
		mostrarEstado(2);
		ShiftRows();
		mostrarEstado(3);
		MixColumns();
		mostrarEstado(4);
		AddRoundKey(rodada);
		mostrarEstado(1);
	}

	// aqui executa a ultima rodada, sem o MixColums
	SubBytes();
	mostrarEstado(2);
	ShiftRows();
	mostrarEstado(3);
	AddRoundKey(N_rodadas);
	mostrarEstado(1);

	// aqui eh copiado o texto criptografado para o vetor de saida
	for(i = 0 ; i < 4 ; i++)
	{
		for(j = 0 ; j < 4 ; j++)
		{
			saida_crip[i*4+j] = estados_parciais[j][i];
		}
	}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++??
//+++++++++++++++++++++RICARDO+++++++++++++++++++++++++++??
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++??

void mostrarEstado(int op){
	int a = 0;
	int b = 7;

	switch(op){
		case 0:
			printf("//Estado Inicial Ou Final\n");
		break;
		case 1:
			printf("//AddRoundKey\n");
			printf("#25\n");
		break;
		case 2:
			printf("//SubBytes\n");
			printf("#25\n");
		break;
		case 3:
			printf("//ShiftRows\n");
			printf("#25\n");
		break;
		case 4:
			printf("//MixColumns\n");
			printf("#25\n");
		break;
	}
	
	for (int i = 0; i < 4; i++)
	{
		for (int j = 0; j < 4; j++)
		{
			printf("blocoInTB[%d:%d] = 8'h%02x;\n",a,b,estados_parciais[i][j]);
			a+=8;
			b+=8;	
		}
	}
	printf("\n\n");
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++??
//+++++++++++++++++++++RICARDO+++++++++++++++++++++++++++??
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++??


int main() {


	int i, op = 0;
	int count = 0;

	//PERF_RESET(PERFORMANCE_COUNTER_BASE);
	//PERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);
	//PERF_BEGIN(PERFORMANCE_COUNTER_BASE,1);
	for (count = 0; count < 10000; count++);

		// aqui calcula o N_chave e o N_rodadas
		N_chave = 128 / 32;
		N_rodadas = N_chave + 6;


	    // aqui para fazer um teste definimos a chave de entrada e o texto para ser criptografado
		//unsigned char chave_teste[32] = {0x00  ,0x01  ,0x02  ,0x03  ,0x04  ,0x05  ,0x06  ,0x07  ,0x08  ,0x09  ,0x0a  ,0x0b  ,0x0c  ,0x0d  ,0x0e  ,0x0f};
		//unsigned char texto_teste[32] = {0x00  ,0x11  ,0x22  ,0x33  ,0x44  ,0x55  ,0x66  ,0x77  ,0x88  ,0x99  ,0xaa  ,0xbb  ,0xcc  ,0xdd  ,0xee  ,0xff};

		//CHAVE:   2b 7e 15 16 28 ae d2 a6 ab f7 15 88 09 cf 4f 3c
		//ENTRADA: 6b c1 be e2 2e 40 9f 96 e9 3d 7e 11 73 93 17 2a

		unsigned char chave_teste[32] = {0x2b  ,0x7e  ,0x15  ,0x16  ,0x28  ,0xae  ,0xd2  ,0xa6  ,0xab  ,0xf7  ,0x15  ,0x88  ,0x09  ,0xcf  ,0x4f  ,0x3c};
		unsigned char texto_teste[32] = {0x6b  ,0xc1  ,0xbe  ,0xe2  ,0x2e  ,0x40  ,0x9f  ,0x96  ,0xe9  ,0x3d  ,0x7e  ,0x11  ,0x73  ,0x93  ,0x17  ,0x2a};
		
		//SAIDA: 3a d7 7b b4 0d 7a 36 60 a8 9e ca f3 24 66 ef 97 
		//SOFTWARE VALIDADO EM 5/12 as 17 Horas(pg31PDFNIST)

		// aqui copia a chave e o texto para os vetores de execucao
		for(i = 0 ; i < N_chave * 4 ; i++)
		{
			chave[i] = chave_teste[i];
			texto_crip[i] = texto_teste[i];
		}
	//}

	    // aqui chamamos a funcao de expandir a chave
		chave_expansao();

		// aqui chamamos a funcao que implementa o AES e criptografa o texto
		//for(i=0; i < 100; i++){
		crip_texto();
		//printf("\n entrei aqui \n");
		//printf("flag %d ", f);	//}
		//printf("result %02x ",teste);
		// aqui mostra na tela o texto criptografado
		printf("\n Texto apos a criptografia:\n");
		for(i = 0 ; i < N_colunas * 4 ; i++)
		{
			printf("%02x ",saida_crip[i]);
		}
	printf("\n\n");

	//PERF_END(PERFORMANCE_COUNTER_BASE,1);
	//PERF_STOP_MEASURING(PERFORMANCE_COUNTER_BASE);
	//perf_print_formatted_report((void*)PERFORMANCE_COUNTER_BASE, ALT_CPU_FREQ,2, "total", "rate1");
	return 0;
}

