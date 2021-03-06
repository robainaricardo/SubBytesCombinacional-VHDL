//Modulo em hardware da etapa SubBytes, algoritmo de criptografia AES.
//Autor: Ricardo Robaina 2017
//Linguagem: Verilog


//Modulo SubBytes sem as tecinicas lowPower
module SubBytes ( input clock, input reset, input [0:127]blocoIn, output reg [0:127]blocoOut);
	
	//decalrando sinais de cada bite separado
	wire [0:7] in [0:15]; //sinal que separa cada byte da matriz apartir da entrada
	wire [0:7] out [0:15];//sinal que será atribuido, em cada byte, a saida da operação SubBytes. 

	
	
	
	//Ligando o blocoIn nos respecitvos bytes do in
	//O and com o aneble é o OperandIsolation
	assign in[0] = blocoIn[0:7];
	assign in[1] = blocoIn[8:15];
	assign in[2] = blocoIn[16:23];
	assign in[3] = blocoIn[24:31];
	assign in[4] = blocoIn[32:39];
	assign in[5] = blocoIn[40:47];
	assign in[6] = blocoIn[48:55];
	assign in[7] = blocoIn[56:63];
	assign in[8] = blocoIn[64:71];
	assign in[9] = blocoIn[72:79];
	assign in[10] = blocoIn[80:87];
	assign in[11] = blocoIn[88:95];
	assign in[12] = blocoIn[96:103];
	assign in[13] = blocoIn[104:111];
	assign in[14] = blocoIn[112:119];
	assign in[15] = blocoIn[120:127];	
	
	
	//Declaracao da Sbox como ROM
	wire  [0:7] sBox [0:255];
	
	//Insercao dos valores na sBox
	assign sBox[0] = 8'b01100011;
	assign sBox[1] = 8'b01111100;
	assign sBox[2] = 8'b01110111;
	assign sBox[3] = 8'b01111011;
	assign sBox[4] = 8'b11110010;
	assign sBox[5] = 8'b01101011;
	assign sBox[6] = 8'b01101111;
	assign sBox[7] = 8'b11000101;
	assign sBox[8] = 8'b00110000;
	assign sBox[9] = 8'b00000001;
	assign sBox[10] = 8'b01100111;
	assign sBox[11] = 8'b00101011;
	assign sBox[12] = 8'b11111110;
	assign sBox[13] = 8'b11010111;
	assign sBox[14] = 8'b10101011;
	assign sBox[15] = 8'b01110110;
	assign sBox[16] = 8'b11001010;
	assign sBox[17] = 8'b10000010;
	assign sBox[18] = 8'b11001001;
	assign sBox[19] = 8'b01111101;
	assign sBox[20] = 8'b11111010;
	assign sBox[21] = 8'b01011001;
	assign sBox[22] = 8'b01000111;
	assign sBox[23] = 8'b11110000;
	assign sBox[24] = 8'b10101101;
	assign sBox[25] = 8'b11010100;
	assign sBox[26] = 8'b10100010;
	assign sBox[27] = 8'b10101111;
	assign sBox[28] = 8'b10011100;
	assign sBox[29] = 8'b10100100;
	assign sBox[30] = 8'b01110010;
	assign sBox[31] = 8'b11000000;
	assign sBox[32] = 8'b10110111;
	assign sBox[33] = 8'b11111101;
	assign sBox[34] = 8'b10010011;
	assign sBox[35] = 8'b00100110;
	assign sBox[36] = 8'b00110110;
	assign sBox[37] = 8'b00111111;
	assign sBox[38] = 8'b11110111;
	assign sBox[39] = 8'b11001100;
	assign sBox[40] = 8'b00110100;
	assign sBox[41] = 8'b10100101;
	assign sBox[42] = 8'b11100101;
	assign sBox[43] = 8'b11110001;
	assign sBox[44] = 8'b01110001;
	assign sBox[45] = 8'b11011000;
	assign sBox[46] = 8'b00110001;
	assign sBox[47] = 8'b00010101;
	assign sBox[48] = 8'b00000100;
	assign sBox[49] = 8'b11000111;
	assign sBox[50] = 8'b00100011;
	assign sBox[51] = 8'b11000011;
	assign sBox[52] = 8'b00011000;
	assign sBox[53] = 8'b10010110;
	assign sBox[54] = 8'b00000101;
	assign sBox[55] = 8'b10011010;
	assign sBox[56] = 8'b00000111;
	assign sBox[57] = 8'b00010010;
	assign sBox[58] = 8'b10000000;
	assign sBox[59] = 8'b11100010;
	assign sBox[60] = 8'b11101011;
	assign sBox[61] = 8'b00100111;
	assign sBox[62] = 8'b10110010;
	assign sBox[63] = 8'b01110101;
	assign sBox[64] = 8'b00001001;
	assign sBox[65] = 8'b10000011;
	assign sBox[66] = 8'b00101100;
	assign sBox[67] = 8'b00011010;
	assign sBox[68] = 8'b00011011;
	assign sBox[69] = 8'b01101110;
	assign sBox[70] = 8'b01011010;
	assign sBox[71] = 8'b10100000;
	assign sBox[72] = 8'b01010010;
	assign sBox[73] = 8'b00111011;
	assign sBox[74] = 8'b11010110;
	assign sBox[75] = 8'b10110011;
	assign sBox[76] = 8'b00101001;
	assign sBox[77] = 8'b11100011;
	assign sBox[78] = 8'b00101111;
	assign sBox[79] = 8'b10000100;
	assign sBox[80] = 8'b01010011;
	assign sBox[81] = 8'b11010001;
	assign sBox[82] = 8'b00000000;
	assign sBox[83] = 8'b11101101;
	assign sBox[84] = 8'b00100000;
	assign sBox[85] = 8'b11111100;
	assign sBox[86] = 8'b10110001;
	assign sBox[87] = 8'b01011011;
	assign sBox[88] = 8'b01101010;
	assign sBox[89] = 8'b11001011;
	assign sBox[90] = 8'b10111110;
	assign sBox[91] = 8'b00111001;
	assign sBox[92] = 8'b01001010;
	assign sBox[93] = 8'b01001100;
	assign sBox[94] = 8'b01011000;
	assign sBox[95] = 8'b11001111;
	assign sBox[96] = 8'b11010000;
	assign sBox[97] = 8'b11101111;
	assign sBox[98] = 8'b10101010;
	assign sBox[99] = 8'b11111011;
	assign sBox[100] = 8'b01000011;
	assign sBox[101] = 8'b01001101;
	assign sBox[102] = 8'b00110011;
	assign sBox[103] = 8'b10000101;
	assign sBox[104] = 8'b01000101;
	assign sBox[105] = 8'b11111001;
	assign sBox[106] = 8'b00000010;
	assign sBox[107] = 8'b01111111;
	assign sBox[108] = 8'b01010000;
	assign sBox[109] = 8'b00111100;
	assign sBox[110] = 8'b10011111;
	assign sBox[111] = 8'b10101000;
	assign sBox[112] = 8'b01010001;
	assign sBox[113] = 8'b10100011;
	assign sBox[114] = 8'b01000000;
	assign sBox[115] = 8'b10001111;
	assign sBox[116] = 8'b10010010;
	assign sBox[117] = 8'b10011101;
	assign sBox[118] = 8'b00111000;
	assign sBox[119] = 8'b11110101;
	assign sBox[120] = 8'b10111100;
	assign sBox[121] = 8'b10110110;
	assign sBox[122] = 8'b11011010;
	assign sBox[123] = 8'b00100001;
	assign sBox[124] = 8'b00010000;
	assign sBox[125] = 8'b11111111;
	assign sBox[126] = 8'b11110011;
	assign sBox[127] = 8'b11010010;
	assign sBox[128] = 8'b11001101;
	assign sBox[129] = 8'b00001100;
	assign sBox[130] = 8'b00010011;
	assign sBox[131] = 8'b11101100;
	assign sBox[132] = 8'b01011111;
	assign sBox[133] = 8'b10010111;
	assign sBox[134] = 8'b01000100;
	assign sBox[135] = 8'b00010111;
	assign sBox[136] = 8'b11000100;
	assign sBox[137] = 8'b10100111;
	assign sBox[138] = 8'b01111110;
	assign sBox[139] = 8'b00111101;
	assign sBox[140] = 8'b01100100;
	assign sBox[141] = 8'b01011101;
	assign sBox[142] = 8'b00011001;
	assign sBox[143] = 8'b01110011;
	assign sBox[144] = 8'b01100000;
	assign sBox[145] = 8'b10000001;
	assign sBox[146] = 8'b01001111;
	assign sBox[147] = 8'b11011100;
	assign sBox[148] = 8'b00100010;
	assign sBox[149] = 8'b00101010;
	assign sBox[150] = 8'b10010000;
	assign sBox[151] = 8'b10001000;
	assign sBox[152] = 8'b01000110;
	assign sBox[153] = 8'b11101110;
	assign sBox[154] = 8'b10111000;
	assign sBox[155] = 8'b00010100;
	assign sBox[156] = 8'b11011110;
	assign sBox[157] = 8'b01011110;
	assign sBox[158] = 8'b00001011;
	assign sBox[159] = 8'b11011011;
	assign sBox[160] = 8'b11100000;
	assign sBox[161] = 8'b00110010;
	assign sBox[162] = 8'b00111010;
	assign sBox[163] = 8'b00001010;
	assign sBox[164] = 8'b01001001;
	assign sBox[165] = 8'b00000110;
	assign sBox[166] = 8'b00100100;
	assign sBox[167] = 8'b01011100;
	assign sBox[168] = 8'b11000010;
	assign sBox[169] = 8'b11010011;
	assign sBox[170] = 8'b10101100;
	assign sBox[171] = 8'b01100010;
	assign sBox[172] = 8'b10010001;
	assign sBox[173] = 8'b10010101;
	assign sBox[174] = 8'b11100100;
	assign sBox[175] = 8'b01111001;
	assign sBox[176] = 8'b11100111;
	assign sBox[177] = 8'b11001000;
	assign sBox[178] = 8'b00110111;
	assign sBox[179] = 8'b01101101;
	assign sBox[180] = 8'b10001101;
	assign sBox[181] = 8'b11010101;
	assign sBox[182] = 8'b01001110;
	assign sBox[183] = 8'b10101001;
	assign sBox[184] = 8'b01101100;
	assign sBox[185] = 8'b01010110;
	assign sBox[186] = 8'b11110100;
	assign sBox[187] = 8'b11101010;
	assign sBox[188] = 8'b01100101;
	assign sBox[189] = 8'b01111010;
	assign sBox[190] = 8'b10101110;
	assign sBox[191] = 8'b00001000;
	assign sBox[192] = 8'b10111010;
	assign sBox[193] = 8'b01111000;
	assign sBox[194] = 8'b00100101;
	assign sBox[195] = 8'b00101110;
	assign sBox[196] = 8'b00011100;
	assign sBox[197] = 8'b10100110;
	assign sBox[198] = 8'b10110100;
	assign sBox[199] = 8'b11000110;
	assign sBox[200] = 8'b11101000;
	assign sBox[201] = 8'b11011101;
	assign sBox[202] = 8'b01110100;
	assign sBox[203] = 8'b00011111;
	assign sBox[204] = 8'b01001011;
	assign sBox[205] = 8'b10111101;
	assign sBox[206] = 8'b10001011;
	assign sBox[207] = 8'b10001010;
	assign sBox[208] = 8'b01110000;
	assign sBox[209] = 8'b00111110;
	assign sBox[210] = 8'b10110101;
	assign sBox[211] = 8'b01100110;
	assign sBox[212] = 8'b01001000;
	assign sBox[213] = 8'b00000011;
	assign sBox[214] = 8'b11110110;
	assign sBox[215] = 8'b00001110;
	assign sBox[216] = 8'b01100001;
	assign sBox[217] = 8'b00110101;
	assign sBox[218] = 8'b01010111;
	assign sBox[219] = 8'b10111001;
	assign sBox[220] = 8'b10000110;
	assign sBox[221] = 8'b11000001;
	assign sBox[222] = 8'b00011101;
	assign sBox[223] = 8'b10011110;
	assign sBox[224] = 8'b11100001;
	assign sBox[225] = 8'b11111000;
	assign sBox[226] = 8'b10011000;
	assign sBox[227] = 8'b00010001;
	assign sBox[228] = 8'b01101001;
	assign sBox[229] = 8'b11011001;
	assign sBox[230] = 8'b10001110;
	assign sBox[231] = 8'b10010100;
	assign sBox[232] = 8'b10011011;
	assign sBox[233] = 8'b00011110;
	assign sBox[234] = 8'b10000111;
	assign sBox[235] = 8'b11101001;
	assign sBox[236] = 8'b11001110;
	assign sBox[237] = 8'b01010101;
	assign sBox[238] = 8'b00101000;
	assign sBox[239] = 8'b11011111;
	assign sBox[240] = 8'b10001100;
	assign sBox[241] = 8'b10100001;
	assign sBox[242] = 8'b10001001;
	assign sBox[243] = 8'b00001101;
	assign sBox[244] = 8'b10111111;
	assign sBox[245] = 8'b11100110;
	assign sBox[246] = 8'b01000010;
	assign sBox[247] = 8'b01101000;
	assign sBox[248] = 8'b01000001;
	assign sBox[249] = 8'b10011001;
	assign sBox[250] = 8'b00101101;
	assign sBox[251] = 8'b00001111;
	assign sBox[252] = 8'b10110000;
	assign sBox[253] = 8'b01010100;
	assign sBox[254] = 8'b10111011;
	assign sBox[255] = 8'b00010110;
	
	//Operação do SubBytes
	assign out[0] = sBox[({4'b0000,(in[0][0:3])}<<4)+(in[0][4:7])];
	assign out[1] = sBox[({4'b0000,(in[1][0:3])}<<4)+(in[1][4:7])];
	assign out[2] = sBox[({4'b0000,(in[2][0:3])}<<4)+(in[2][4:7])];
	assign out[3] = sBox[({4'b0000,(in[3][0:3])}<<4)+(in[3][4:7])];
	assign out[4] = sBox[({4'b0000,(in[4][0:3])}<<4)+(in[4][4:7])];
	assign out[5] = sBox[({4'b0000,(in[5][0:3])}<<4)+(in[5][4:7])];
	assign out[6] = sBox[({4'b0000,(in[6][0:3])}<<4)+(in[6][4:7])];
	assign out[7] = sBox[({4'b0000,(in[7][0:3])}<<4)+(in[7][4:7])];
	assign out[8] = sBox[({4'b0000,(in[8][0:3])}<<4)+(in[8][4:7])];
	assign out[9] = sBox[({4'b0000,(in[9][0:3])}<<4)+(in[9][4:7])];
	assign out[10] = sBox[({4'b0000,(in[10][0:3])}<<4)+(in[10][4:7])];
	assign out[11] = sBox[({4'b0000,(in[11][0:3])}<<4)+(in[11][4:7])];
	assign out[12] = sBox[({4'b0000,(in[12][0:3])}<<4)+(in[12][4:7])];
	assign out[13] = sBox[({4'b0000,(in[13][0:3])}<<4)+(in[13][4:7])];
	assign out[14] = sBox[({4'b0000,(in[14][0:3])}<<4)+(in[14][4:7])];
	assign out[15] = sBox[({4'b0000,(in[15][0:3])}<<4)+(in[15][4:7])];
	
	
	always @(posedge clock, posedge reset)
	begin
		if (reset) begin
			//ZERAR A SAIDA
			blocoOut[0:7] 	   <= 8'b00000000;
			blocoOut[8:15]     <= 8'b00000000;
			blocoOut[16:23]    <= 8'b00000000;
			blocoOut[24:31]    <= 8'b00000000;
			blocoOut[32:39]    <= 8'b00000000;
			blocoOut[40:47]    <= 8'b00000000;
			blocoOut[48:55]    <= 8'b00000000;
			blocoOut[56:63]    <= 8'b00000000;
			blocoOut[64:71]    <= 8'b00000000;
			blocoOut[72:79]    <= 8'b00000000;
			blocoOut[80:87]    <= 8'b00000000;
			blocoOut[88:95]    <= 8'b00000000;
			blocoOut[96:103]   <= 8'b00000000;
			blocoOut[104:111]  <= 8'b00000000;
			blocoOut[112:119]  <= 8'b00000000;
			blocoOut[120:127]  <= 8'b00000000;		
		end
		else
			//PASSA O OUT PARA O BLOCO OUT
			blocoOut[0:7]      <= out[0];
			blocoOut[8:15]     <= out[1];
			blocoOut[16:23]    <= out[2];
			blocoOut[24:31]    <= out[3];
			blocoOut[32:39]    <= out[4];
			blocoOut[40:47]    <= out[5];
			blocoOut[48:55]    <= out[6];
			blocoOut[56:63]    <= out[7];
			blocoOut[64:71]    <= out[8];
			blocoOut[72:79]    <= out[9];
			blocoOut[80:87]    <= out[10];
			blocoOut[88:95]    <= out[11];
			blocoOut[96:103]   <= out[12];
			blocoOut[104:111]  <= out[13];
			blocoOut[112:119]  <= out[14];
			blocoOut[120:127]  <= out[15];	
		end

endmodule 
