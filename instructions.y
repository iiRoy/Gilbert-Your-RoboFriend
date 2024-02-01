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

	YACC Syntax Interpreter
*/

/* 	DEFINICIONES     */ 

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern FILE *yyin;
extern FILE *outputFile;

extern char *fullSentence;
extern int verify;
char *description = NULL;
void yyerror(const char *s);
int yylex(void);


char* verb = "";
int value = 0;
int set = 0;
int printing = 1;

// Function to safely append text to fullSentence
	void appendToDescription(const char *text) {
		if (text == NULL) return;
        
		size_t newLenDesc = strlen(description) + strlen(text) + 1;
		description = (char *)realloc(description, newLenDesc * sizeof(char));
		if (description == NULL) {
			perror("Failed to reallocate memory");
			exit(1);
		}
		strcat(description, text);
    	}
%}

/* 	IDENTIFICADORES     */ 

%union {
    char *dir;
}


%token ROBOT PETITION DEGREES FRONT BACK ASKING COMMA PERIOD QUEST EXCLA SEMICOL KINDLY MOVE PROJECT TURN SINGLE NUM PLU_BLOCKS SING_BLOCKS DIREC_90 DIREC_180 DIREC_270 DIREC_360  DIREC_LEFT DIREC_RIGHT DIREC_AROUND CONJ_THEN CONJ_ALSO CONJ_AND EOL OTHER
%start INPUT

/* 	REGLAS     */ 

%%

/* Reglas de la Gramática Adaptada */

INPUT: 					/* Espacio en blanco */  
	    					| INPUT EOL { set = 0; }
            					| INPUT SENTENCE { 	
												set=1; 
												if (printing == 1) {	
													printf("\033[1;33m\"%s\"\033[1;0m\n", fullSentence); 
													memset(fullSentence, 0, sizeof(fullSentence)); 
												}												
												printf("\033[1;35m%s\033[1;0m", description); 
												memset(description, 0, sizeof(description)); 
												printf("\033[1;32mI understood your whole petition loud and clearly and I will do it as you wished!\033[1;0m\n\033[1;36mAnything else I can help you with?\033[1;0m\n\n\n"); 
												}
	    					| INPUT error EOL { 
												set=0;
												if (printing == 1) {	
													printf("\033[1;33m\"%s\"\033[1;0m\n", fullSentence); 
													memset(fullSentence, 0, sizeof(fullSentence)); 
												}	
												printf("\033[1;35m%s\033[1;0m", description); 
												memset(description, 0, sizeof(description)); 					
												yyerrok; 
												yyclearin;
												printf("\033[1;31mSorry... There was a part of your sentence I didn't understand. If there's any actions I mentioned, there's \nRemember to talk nicely to me, and to use proper grammar for better understanding.\nIf you think this is a mistake, I encourage you to check the file named 'README.md' for more information.\033[1;0m\n\033[1;36mAnything else I can help you with?\033[1;0m\n\n\n"); 
												verify = 0;												
												}
            					;

SENTENCE: 				NOUN_PHRASE VERB_PHRASE //{ printf("SENTENCE\n"); }
    						;

NOUN_PHRASE : 			CMPLX_NOUN //{ printf("NOUN_PHRASE\n"); }
    						;

VERB_PHRASE : 			VERB SIGN//{ printf("VERB_PHRASE\n"); }
    						| VERB CONJ_PHRASE  //{ printf("VERB_PHRASE\n"); }
    						;

CMPLX_NOUN : 			ROBOT ASK //{ printf("CMPLX_NOUN\n"); }
    						| ROBOT COMMA ASK //{ printf("CMPLX_NOUN\n"); }
						;

ASK: 					KINDLY ASKING { appendToDescription("Thanks for being so nice with me!\n"); }
         					| ASKING { appendToDescription("Thanks for asking properly.\n"); }
	 					| PETITION KINDLY ASKING { appendToDescription("Thanks for being so nice with your petition!\n"); }
	 					| PETITION ASKING { appendToDescription("Thanks for giving me your petition so nicely!\n"); }
	 					;

VERB : 					MOVING //{ appendToDescription("I will move "); appendToDescription(variable); appendToDescription(" blocks.\n"); }
    						| TURNING //{ appendToDescription("VERB\n"); }
						| PROJECTING
    						;

PROJECTING :			PROJECT { appendToDescription("Projecting position...\n"); }
						;

MOVING : 				MOVE BLOCKS { verb = "MOV"; /*printf("MOVING\n");*/ }
		 				| MOVE { verb = "MOV"; value = 1; }
						| MOVE TO 
						| MOVE BLOCKS TO 
						| MOVE TO BLOCKS
    						;

TO:						FRONT 
						| BACK
						;

TURNING : 				TURN DIRECTION { verb = "TURN"; /*printf("TURNING\n");*/ }
		   				| TURN { verb = "TURN"; value = 90; }
    						;

BLOCKS : 				SINGLE SING_BLOCKS { value = 1; /*printf("1 SPACE");*/ }
						| NUM PLU_BLOCKS { value = NUM; /*printf("# SPACES");*/ }
						| SINGLE { value = 1; /*printf("1");*/ }
						| NUM { value = NUM; /*printf("#");*/ }
						;

DIRECTION : 				DIREC_RIGHT { value = 90; /*printf("DIREC_RIGHT\n");*/ } 
		     				| DIREC_AROUND { value = 180; /*printf("DIREC_AROUND\n");*/ }
		     				| DIREC_LEFT { value = 270; /*printf("DIREC_LEFT\n");*/ }
						| DIREC_90 DEGREES { value = 90; /*printf("DIREC_RIGHT\n");*/ } 
						| DIREC_180 DEGREES { value = 90; /*printf("DIREC_RIGHT\n");*/ } 
						| DIREC_270 DEGREES { value = 270; /*printf("DIREC_LEFT\n");*/ }
						| DIREC_360 DEGREES { value = 360; /*printf("DIREC_LEFT\n");*/ }
		     				;

CONJ_PHRASE: 			COMMA CONJ_THEN VERB_PHRASE //{printf("CONJ_THEN\n");}
						| COMMA CONJ_AND VERB_PHRASE //{printf("CONJ_AND\n");}
						| COMMA CONJ_AND CONJ_THEN VERB_PHRASE //{printf("CONJ_AND CONJ_THEN\n");}
						| SIGN CONJ_ALSO COMMA ASK VERB_PHRASE //{printf("CONJ_ALSO ASK\n");}
						| SIGN CONJ_ALSO COMMA VERB_PHRASE //{printf("CONJ_ALSO\n");}
						| COMMA VERB_PHRASE //{printf("CONJ_PHRASE\n");}
    						;

SIGN :					PERIOD
						| EXCLA
						| QUEST
						;

%%

/* 	ERRORES GENERADOS     */ 

void yyerror(const char *s) {
}

/* 	PROGRAMA PRINCIPAL     */ 

void title(){

printf("\n\t████████████████████████████████████████████████████████████████████████████████████████████████████████████\n\t█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░█████████░░░░░░░░░░░░░░███░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░███░░░░░░░░░░░░░░█\n\t█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀▄▀▄▀▄▀░░█\n\t█░░▄▀░░░░░░░░░░█░░░░▄▀░░░░█░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███░░░░░░▄▀░░░░░░█\n\t█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███░░▄▀░░█████████░░▄▀░░████░░▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░░░░░███░░▄▀░░███░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░████░░▄▀░░█░░▄▀░░█████████░░▄▀░░██░░▄▀░░█████████░░▄▀░░█████\n\t█░░▄▀░░░░░░▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░░░█████░░▄▀░░█████\n\t█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀░░█████░░▄▀░░█████\n\t█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░░░█████░░░░░░█████\n\t████████████████████████████████████████████████████████████████████████████████████████████████████████████\n\n");

}

int main() {
	// Clear the terminal screen
	#ifdef _WIN32
        	system("cls");
	#else
		system("clear");
	#endif

    	char choice[10];
    	FILE *fd = NULL;

	    title();
	    printf("\033[1;36mEnter '1' to read from 'instructions.txt', '2' to read from the terminal, or '0' to exit the program: \033[1;0m");
	    scanf("%9s", choice);
	    
	   // Allocate initial memory for the sentence and descriptions
    	   fullSentence = (char *)malloc(1024 * sizeof(char));
    	   if (fullSentence == NULL) {
    	     	perror("Failed to allocate memory");
           	exit(1);
    	   }
    	   fullSentence[0] = '\0'; // Initialize to an empty string
		
	  description = (char *)malloc(1024 * sizeof(char));
	  if (description == NULL) {
		perror("Failed to allocate memory");
		exit(1);
	   }
	   description[0] = '\0'; // Initialize to an empty string
	
	    if (strcmp(choice, "1") == 0) {
	        fd = fopen("instructions.txt", "r");
		printf("\033[1;36mReading from file... Wait a moment:\033[1;0m\n\n");
	        if (!fd) {
	            perror("Error opening file");
	            return -1;
	        }
	        yyin = fd; // Set yyin to read from the file
	    } else if (strcmp(choice, "2") == 0) {
		printing = 0;	        
		printf("\033[1;36mReading from terminal. Enter your input:\033[1;0m\n\n");
	        yyin = stdin; // Set yyin to read from standard input (terminal)
	    } else if (strcmp(choice, "0") == 0) {
	        printf("\033[1;36mExiting... Thanks for using Gilbert!\033[1;0m\n\n");
	        return 0;
	    } else {
	        printf("\033[1;31mInvalid choice. Exiting... Thanks for using Gilbert!\033[1;0m\n\n");
	        return 1;
	    }

	yyparse();
	if (set == 0 && verify == 1){
		if (printing == 1) {		
			printf("\033[1;33m\"%s\"\033[1;0m\n", fullSentence); 
			memset(fullSentence, 0, sizeof(fullSentence)); 	
		}
		printf("\033[1;35m%s\033[1;0m", description); 
		memset(description, 0, sizeof(description)); 		    		
		printf("\033[1;31mSorry... There was a part of your sentence I didn't understand. If there's any actions I mentioned, there's \nRemember to talk nicely to me, and to use proper grammar for better understanding.\nIf you think this is a mistake, I encourage you to check the file named 'README.md' for more information.\033[1;0m\n\n\n"); // Se pone este comparador ya que al finalizar todas las reglas, YACC es incapaz de devolver la regla para un error. (SOLO SE USA EN CASO DE QUE EL USUARIO USE EL ARCHIVO 'instruction.txt')
	}
	printf("\033[1;36mExiting... Thanks for using Gilbert!\033[1;0m\n\n");

    	if (fd != NULL) {
        	fclose(fd);  // Cerrar el archivo si está abierto
    	}
	
	// Free the allocated memory
    	free(fullSentence);
    	fullSentence = NULL;

	free(description);
	description = NULL;

	return 0;
}
