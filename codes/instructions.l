/* 	
	STUDENTS INFORMATION:
	
		YACC & LEX CODER:
		Rodrigo López Guerra
		A01737437

		PYTHON MATRIX CODER:
		Valter Alejandro Kuhne Hernandez
		A01379392

		LEX CODER:
		Ximena Cantera Reséndiz
		A01277310	

	Lexical Analyzer Program
*/

/* 	DEFINICIONES     */ 

%{
#include "y.tab.h"
char *fullSentence = NULL;
int verify = 0;

// Function to safely append text to fullSentence
	void appendToSentence(const char *text) {
		if (text == NULL) return;
        
		size_t newLen = strlen(fullSentence) + strlen(text) + 1;
		fullSentence = (char *)realloc(fullSentence, newLen * sizeof(char));
		if (fullSentence == NULL) {
			perror("Failed to reallocate memory");
			exit(1);
		}
		strcat(fullSentence, text);
    	}
%}

/* 	OPCIONES     */ 

%option noyywrap

%x WILL
%x MIND

/* 	RULES AND TOKENS    */ 

%%
<INITIAL>[ \t] |
<WILL>[ \t] |
<MIND>[ \t]		{ appendToSentence(yytext); /* Ignora espacios en blanco */ }

","			{ appendToSentence(yytext); verify = 1; return COMMA; }

"."			{ appendToSentence(yytext); verify = 1; return PERIOD; }

"?"			{ appendToSentence(yytext); verify = 1; return QUEST; }

"!"			{ appendToSentence(yytext); verify = 1; return EXCLA; }

Robot |
Gilbert |
Gentleman		{ appendToSentence(yytext); verify = 1; return ROBOT; } // Robot names

please |
kindly			{ appendToSentence(yytext); verify = 1; return ASKING; } // Please or kindly tokens

mind			{ appendToSentence(yytext); verify = 1; BEGIN(MIND); }		
<MIND>to		{ appendToSentence(yytext); verify = 1; BEGIN(INITIAL); return ASKING; }

pretty 			{ appendToSentence(yytext); verify = 1; return KINDLY; }

will | 
would |
can |
could			{ appendToSentence(yytext); verify = 1; BEGIN(WILL); }
<WILL>you 		{ appendToSentence(yytext); verify = 1; BEGIN(INITIAL); return PETITION; }

move			{ appendToSentence(yytext); verify = 1; return MOVE; }

turn 			{ appendToSentence(yytext); verify = 1; return TURN; }

project			{ appendToSentence(yytext); verify = 1; return PROJECT; }

degrees |
"°"			{ appendToSentence(yytext); verify = 1; return DEGREES; }

left 			{ appendToSentence(yytext); verify = 1; return DIREC_LEFT; }

right 			{ appendToSentence(yytext); verify = 1; return DIREC_RIGHT; }

around 			{ appendToSentence(yytext); verify = 1; return DIREC_AROUND; }

90|180|270|360  	{ appendToSentence(yytext); yylval = atoi(yytext); verify = 1; return DIREC_NUM; } // All directions in degrees

[1]			{ appendToSentence(yytext); verify = 1; return SINGLE; }

[0-9]+			{ appendToSentence(yytext); yylval = atoi(yytext); verify = 1; return NUM; }

blocks |
spaces			{ appendToSentence(yytext); verify = 1; return PLU_BLOCKS; }

block |
space			{ appendToSentence(yytext); verify = 1; return SING_BLOCKS; }

and |
"&"			{ appendToSentence(yytext); verify = 1; return CONJ_AND; }

forward |
straight |
ahead			{ appendToSentence(yytext); verify = 1; return FRONT; }

back |
backward		{ appendToSentence(yytext); verify = 1; return BACK; }

Also			{ appendToSentence(yytext); verify = 1; return CONJ_ALSO; }

then			{ appendToSentence(yytext); verify = 1; return CONJ_THEN; }				

\n          		{ return EOL; verify = 0; }  // End of the line token

<WILL>. |
<MIND>.			{ BEGIN(INITIAL); }    // Transition to INITIAL state after WILL or MIND tokens
.			{ appendToSentence(yytext); verify = 1; return OTHER; } // Other token

%%
