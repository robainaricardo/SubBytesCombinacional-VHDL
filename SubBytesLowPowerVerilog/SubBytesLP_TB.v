module SubBytesLP_TB;
	reg clockTB;
	reg resetTB;
	reg enableTB; 
	reg [0:127]blocoInTB; 
	wire [0:127]blocoOutTB;
	
	
	SubBytesLP instanciaSubBytes(
		.clock (clockTB),
		.reset (resetTB),
		.enableS (enableTB),
		.blocoIn (blocoInTB),
		.blocoOut (blocoOutTB)
	);
	
	initial
	begin
		clockTB = 0;
		resetTB = 0;
		enableTB = 1;
		#2
		resetTB = 1;
		enableTB = 0;
		#2
		resetTB = 0;
		
		#49 //Tempo em que o Expkey e AddroundKey
		blocoInTB[0:7] = 8'h19;
		blocoInTB[8:15] = 8'hA0;
		blocoInTB[16:23] = 8'h9A;
		blocoInTB[24:31] = 8'hE9;
		blocoInTB[32:39] = 8'h3D;
		blocoInTB[40:47] = 8'hF4;
		blocoInTB[48:55] = 8'hC6;
		blocoInTB[56:63] = 8'hF8;
		blocoInTB[64:71] = 8'hE3;
		blocoInTB[72:79] = 8'hE2;
		blocoInTB[80:87] = 8'h8D;
		blocoInTB[88:95] = 8'h48;
		blocoInTB[96:103] = 8'hBE;
		blocoInTB[104:111] = 8'h2B;
		blocoInTB[112:119] = 8'h2A;
		blocoInTB[120:127] = 8'h08;
		/*Resultado deve ser
			D4 E0 B8 1E 
			27 BF B4 41
			11 98 5D 52
			Ae F1 E5 30
			
			0 : 11010100 11100000 10111000 00011110 
			4 : 00100111 10111111 10110100 01000001 
			8 : 00010001 10011000 01011101 01010010 
			12: 10101110 11110001 11100101 00110000 
			
			d4 e0 b8 1e 27 bf b4 41 11 98 5d 52 ae f1 e5 30
			

			
			Funcionando o bloco!! CONFERI EM 11/10
		*/
		//SUB
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		#38
		blocoInTB[0:7] = 8'hA4;
		blocoInTB[8:15] = 8'h68;
		blocoInTB[16:23] = 8'h6B;
		blocoInTB[24:31] = 8'h02;
		blocoInTB[32:39] = 8'h9C;
		blocoInTB[40:47] = 8'h9F;
		blocoInTB[48:55] = 8'h5B;
		blocoInTB[56:63] = 8'h6A;
		blocoInTB[64:71] = 8'h7F;
		blocoInTB[72:79] = 8'h35;
		blocoInTB[80:87] = 8'hEA;
		blocoInTB[88:95] = 8'h50;
		blocoInTB[96:103] = 8'hF2;
		blocoInTB[104:111] = 8'h2B;
		blocoInTB[112:119] = 8'h43;
		blocoInTB[120:127] = 8'h49;
		/*Resultado deve ser
			49 45 7F 77
			DE DB 39 02
			D2 96 87 53
			89 F1 1A 3B
			
			 0 : 01001001 01000101 01111111 01110111 
			 4 : 11011110 11011011 00111001 00000010 
		     8 : 11010010 10010110 10000111 01010011 
			12 : 10001001 11110001 00011010 00111011 
			
			49 45 7f 77 de db 39 02 d2 96 87 53 89 f1 1a 3b
		*/
		
		
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		#38
		blocoInTB[0:7] = 8'hAA;
		blocoInTB[8:15] = 8'h61;
		blocoInTB[16:23] = 8'h82;
		blocoInTB[24:31] = 8'h68;
		blocoInTB[32:39] = 8'h8F;
		blocoInTB[40:47] = 8'hDD;
		blocoInTB[48:55] = 8'hD2;
		blocoInTB[56:63] = 8'h32;
		blocoInTB[64:71] = 8'h5F;
		blocoInTB[72:79] = 8'hE3;
		blocoInTB[80:87] = 8'h4A;
		blocoInTB[88:95] = 8'h46;
		blocoInTB[96:103] = 8'h03;
		blocoInTB[104:111] = 8'hEF;
		blocoInTB[112:119] = 8'hD2;
		blocoInTB[120:127] = 8'h9A;
		/*Resultado deve ser
			AC FF 13 45
			73 C1 B5 23
			CF 11 D6 5A
			7B DF B5 B8
			
			ac ef 13 45 73 c1 b5 23 cf 11 d6 5a 7b df b5 b8
			
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		#38
		blocoInTB[0:7] = 8'h48;
		blocoInTB[8:15] = 8'h67;
		blocoInTB[16:23] = 8'h4D;
		blocoInTB[24:31] = 8'hD6;
		blocoInTB[32:39] = 8'h6C;
		blocoInTB[40:47] = 8'h1D;
		blocoInTB[48:55] = 8'hE3;
		blocoInTB[56:63] = 8'h5F;
		blocoInTB[64:71] = 8'h4E;
		blocoInTB[72:79] = 8'h9D;
		blocoInTB[80:87] = 8'hB1;
		blocoInTB[88:95] = 8'h58;
		blocoInTB[96:103] = 8'hEE;
		blocoInTB[104:111] = 8'h0D;
		blocoInTB[112:119] = 8'h38;
		blocoInTB[120:127] = 8'hE7;
		/*Resultado deve ser
			52 85 E3 F6
			50 A4 11 CF
			2F 5E C8 6A
			28 D7 07 94
			
			52 85 e3 f6 50 a4 11 cf 2f 5e c8 6a 28 d7 07 94
			
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		#38
		blocoInTB[0:7] = 8'hE0;
		blocoInTB[8:15] = 8'hC8;
		blocoInTB[16:23] = 8'hD9;
		blocoInTB[24:31] = 8'h85;
		blocoInTB[32:39] = 8'h92;
		blocoInTB[40:47] = 8'h63;
		blocoInTB[48:55] = 8'hB1;
		blocoInTB[56:63] = 8'hB8;
		blocoInTB[64:71] = 8'h7F;
		blocoInTB[72:79] = 8'h63;
		blocoInTB[80:87] = 8'h35;
		blocoInTB[88:95] = 8'hBE;
		blocoInTB[96:103] = 8'hE8;
		blocoInTB[104:111] = 8'hC0;
		blocoInTB[112:119] = 8'h50;
		blocoInTB[120:127] = 8'h01;
		/*Resultado deve ser
			E1 E8 35 97
			4F FB C8 6C
			D2 FB 96 AE
			9B BA 53 7C
			
			e1 e8 35 97 4f fb c8 6c d2 fb 96 ae 9b ba 53 7c
			
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		
		#38
		blocoInTB[0:7] = 8'hF1;
		blocoInTB[8:15] = 8'hC1;
		blocoInTB[16:23] = 8'h7C;
		blocoInTB[24:31] = 8'h5D;
		blocoInTB[32:39] = 8'h00;
		blocoInTB[40:47] = 8'h92;
		blocoInTB[48:55] = 8'hC8;
		blocoInTB[56:63] = 8'hB5;
		blocoInTB[64:71] = 8'h6F;
		blocoInTB[72:79] = 8'h4C;
		blocoInTB[80:87] = 8'h8B;
		blocoInTB[88:95] = 8'hD5;
		blocoInTB[96:103] = 8'h55;
		blocoInTB[104:111] = 8'hEF;
		blocoInTB[112:119] = 8'h32;
		blocoInTB[120:127] = 8'h0C;
		/*Resultado deve ser
			A1 78 10 4C
			63 4F E8 D5
			A8 29 3D 03
			FC DF 23 FE
			
			a1 78 10 4c 63 4f e8 d5 a8 29 3d 03 fc df 23 fe
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		
		
		#38
		blocoInTB[0:7] = 8'h26;
		blocoInTB[8:15] = 8'h3D;
		blocoInTB[16:23] = 8'hE8;
		blocoInTB[24:31] = 8'hFD;
		blocoInTB[32:39] = 8'h0E;
		blocoInTB[40:47] = 8'h41;
		blocoInTB[48:55] = 8'h64;
		blocoInTB[56:63] = 8'hD2;
		blocoInTB[64:71] = 8'h2E;
		blocoInTB[72:79] = 8'hB7;
		blocoInTB[80:87] = 8'h72;
		blocoInTB[88:95] = 8'h8B;
		blocoInTB[96:103] = 8'h17;
		blocoInTB[104:111] = 8'h7D;
		blocoInTB[112:119] = 8'hA9;
		blocoInTB[120:127] = 8'h25;
		/*Resultado deve ser
			F7 27 9B 54
			AB 83 43 B5
			31 A9 40 3D
			F0 FF D3 3F
			
			f7 27 9b 54 ab 83 43 b5 31 a9 40 3d f0 ff d3 3f
			
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		
		#38
		blocoInTB[0:7] = 8'h5A;
		blocoInTB[8:15] = 8'h19;
		blocoInTB[16:23] = 8'hA3;
		blocoInTB[24:31] = 8'h7A;
		blocoInTB[32:39] = 8'h41;
		blocoInTB[40:47] = 8'h49;
		blocoInTB[48:55] = 8'hE0;
		blocoInTB[56:63] = 8'h8C;
		blocoInTB[64:71] = 8'h42;
		blocoInTB[72:79] = 8'hDC;
		blocoInTB[80:87] = 8'h19;
		blocoInTB[88:95] = 8'h0C;
		blocoInTB[96:103] = 8'hB1;
		blocoInTB[104:111] = 8'h1F;
		blocoInTB[112:119] = 8'h65;
		blocoInTB[120:127] = 8'h0C;
		/*Resultado deve ser
			BE D4 0A DA
			83 3B E1 64
			2C 86 D4 F2
			C8 C0 4D FE
			
			be d4 0a da 83 3b e1 64 2c 86 d4 fe c8 c0 4d fe
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
	
	
	
		#38
		blocoInTB[0:7] = 8'hEA;
		blocoInTB[8:15] = 8'h04;
		blocoInTB[16:23] = 8'h65;
		blocoInTB[24:31] = 8'h85;
		blocoInTB[32:39] = 8'h83;
		blocoInTB[40:47] = 8'h45;
		blocoInTB[48:55] = 8'h5D;
		blocoInTB[56:63] = 8'h96;
		blocoInTB[64:71] = 8'h5C;
		blocoInTB[72:79] = 8'h33;
		blocoInTB[80:87] = 8'h98;
		blocoInTB[88:95] = 8'hB0;
		blocoInTB[96:103] = 8'hF0;
		blocoInTB[104:111] = 8'h2D;
		blocoInTB[112:119] = 8'hAD;
		blocoInTB[120:127] = 8'hC5;
		/*Resultado deve ser
			87 F2 4D 97
			EC 6E 4C 90
			4A C3 46 E7
			8C D8 95 A6
			
			87 f2 4d 97 ec 6e 4c 90 4a c3 46 e7 8c d8 95 a6
			
			
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		
		
		#38
		blocoInTB[0:7] = 8'hEB;
		blocoInTB[8:15] = 8'h59;
		blocoInTB[16:23] = 8'h8B;
		blocoInTB[24:31] = 8'h1B;
		blocoInTB[32:39] = 8'h40;
		blocoInTB[40:47] = 8'h2E;
		blocoInTB[48:55] = 8'hA1;
		blocoInTB[56:63] = 8'hC3;
		blocoInTB[64:71] = 8'hF2;
		blocoInTB[72:79] = 8'h38;
		blocoInTB[80:87] = 8'h13;
		blocoInTB[88:95] = 8'h42;
		blocoInTB[96:103] = 8'h1E;
		blocoInTB[104:111] = 8'h84;
		blocoInTB[112:119] = 8'hE7;
		blocoInTB[120:127] = 8'hD2;
		/*Resultado deve ser
			E9 CB 3D AF
			09 31 32 2E
			89 07 7D 2C
			72 5F 94 B5
			
			e9 cb 3d af 09 31 32 2e 89 07 7d 2c 72 5f 94 b5
		*/
		#1
		enableTB = 1;
		#2
		enableTB = 0;
		#35
		resetTB = 1;
		
	end
	
	always
		#1 clockTB =~clockTB;
		
endmodule