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
#include <signal.h>

extern FILE *yyin;
FILE *fd = NULL;
FILE *file = NULL;

extern char *fullSentence;
extern int verify;
char *description = NULL;
char *instructions=NULL;
void yyerror(const char *s);
int yylex(void);

char choice[10];
char *verb = "";
char *show_direc = "";
int value = 0;
int set = 0;
int printing = 1;
int direction = 0;
int projecting_lock = 0;
int logs = 0;
int temp = 0;
int lock = 0;
int num_matrix = 0;
char *value_char = NULL;

void title(){

	printf("\n\t████████████████████████████████████████████████████████████████████████████████████████████████████████████\n\t█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░█████████░░░░░░░░░░░░░░███░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░███░░░░░░░░░░░░░░█\n\t█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀▄▀▄▀▄▀▄▀░░█\n\t█░░▄▀░░░░░░░░░░█░░░░▄▀░░░░█░░▄▀░░█████████░░▄▀░░░░░░▄▀░░███░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███░░░░░░▄▀░░░░░░█\n\t█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░██░░▄▀░░███░░▄▀░░█████████░░▄▀░░████░░▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░███████████░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░░░░░███░░▄▀░░███░░▄▀░░█████████░░▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░▄▀░░░░███████░░▄▀░░█████\n\t█░░▄▀░░██░░▄▀░░███░░▄▀░░███░░▄▀░░█████████░░▄▀░░████░░▄▀░░█░░▄▀░░█████████░░▄▀░░██░░▄▀░░█████████░░▄▀░░█████\n\t█░░▄▀░░░░░░▄▀░░█░░░░▄▀░░░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░░░░░█████░░▄▀░░█████\n\t█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀░░█████░░▄▀░░█████\n\t█░░░░░░░░░░░░░░█░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░░░░░█████░░░░░░█████\n\t████████████████████████████████████████████████████████████████████████████████████████████████████████████\n\n\n");

}

// Function to safely append text to Description
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

// Function to safely append text to Instructions
void appendToInstructions(const char *text) {
	if (text == NULL) return;
	size_t newLenInst = strlen(instructions) + strlen(text) + 1;
	instructions = (char *)realloc(instructions, newLenInst * sizeof(char));
	if (instructions == NULL) {
		perror("Failed to reallocate memory");
		exit(1);
	}
	strcat(instructions, text);
}

// Function to detect direction
void directioning(int direc){	
	lock = 1;	
	direc = direc % 4;
	if (direc == 0) {
		show_direc =  "north.";
	}	
	if (direc == 1) {
		show_direc = "east.";
	}	
	if (direc == 2) {
		show_direc = "south.";
	}	
	if (direc == 3) {
		show_direc = "west.";
	}
	appendToDescription("Facing ");
	appendToDescription(show_direc);
	appendToDescription("\n");
}

//Function to save an instruction
void save(char *define, int measure) {
	verb = define;		
	value = measure;
	value_char = (char *)malloc(sizeof(char) * 12);
	if (!value_char) {
    		perror("Failed to allocate memory");
    		exit(1);
	}
	sprintf(value_char, "%d ", value);
	appendToInstructions(verb);
	appendToInstructions(value_char);
	if (verb == "TURN, ") {
		appendToDescription("Turning ");
		appendToDescription(value_char);
		appendToDescription("°.\n");		
		if ( lock == 0 ){
			temp = direction;
		}	
		if (value == 90){
			direction += 1;
			directioning(direction);
		}
		if (value == 180){
			direction += 2;
			directioning(direction);
		}
		if (value == 270){
			direction += 3;
			directioning(direction);
		}
		if (value == 360){
			direction += 4;
			directioning(direction);
		}		
	}
	if (verb == "MOV, ") {
		appendToDescription("Moving ");
		appendToDescription(value_char);
		if (value == 1){
			appendToDescription("block.\n");	
		} else {
			appendToDescription("blocks.\n");
		}
	}
	free(value_char);
	value_char = NULL;
} 

void toFile(char *instructions) {
	file = fopen("instructions.asm", "a");
	if (file == NULL) {
        	perror("Error opening file");
        	return;
    	}
	int wordCount = 0;
    	char *token = strtok(instructions, " ");  // Tokenize the string by spaces
    	while (token != NULL) {
        	fprintf(file, "%s ", token);  // Write the word to the file
        	wordCount++;
        	if (wordCount == 2) {
            		fprintf(file, "\n");  // Insert a newline after every two words
            		wordCount = 0;
        	}
        	token = strtok(NULL, " ");  // Get the next token
    	}
	fclose(file);  // Cerrar el archivo si está abierto
}

void result() {
	if (printing == 1) {	
		printf("\033[1;33m\"%s\"\033[1;0m\n", fullSentence); 
		memset(fullSentence, 0, sizeof(fullSentence)); 
	}
	if (logs == 1 && set == 1) {	
		if (projecting_lock == 1) {
			projecting_lock = 2;
			num_matrix += 1;	
			value_char = (char *)malloc(sizeof(char) * 12);
			if (!value_char) {
				perror("Failed to allocate memory");
				exit(1);
			}
			sprintf(value_char, "%d ", num_matrix);																	
			appendToDescription("Projecting position in MATRIX ");
			appendToDescription(value_char);
			appendToDescription("...\n");
		}
		printf("\033[1;35m%s\033[1;0m", description); 
		memset(description, 0, sizeof(description));
	}
	if (set == 1) {
		toFile(instructions);
		if (projecting_lock != 0) {
			if (projecting_lock == 1){
				num_matrix += 1;	
			}
			char command[100];
			sprintf(command, "python instructions.py %d", num_matrix);
			system(command);
			free(value_char);
			value_char = NULL; 
		}		
		printf("\033[1;32mI understood your whole petition loud and clearly. I will do it as you wished!\033[1;0m\n");	
		printf("\033[1;36mI will be here if there's anything else you need.\033[1;0m\n\n\n");
		memset(instructions, 0, sizeof(instructions)); 
		lock = 0;
		projecting_lock = 0;
	} else {
		printf("\033[1;31mSorry. I didn't understand you.\n");
		printf("\033[1;36mCould you repeat your petition with a language I can understand?\033[1;0m\n\n\n");
		memset(instructions, 0, sizeof(instructions)); 
		memset(description, 0, sizeof(description));
		direction = temp;
		lock = 0;
		projecting_lock = 0;
	}	
}

%}

/* 	TOKENS    */ 

//NOUNS AND PETITIONS
%token ROBOT PETITION KINDLY ASKING
//VERBS AND COMPLEMENTS
%token MOVE PROJECT TURN
//DIRECTIONS AND QUANTITY
%token FRONT BACK SINGLE NUM PLU_BLOCKS SING_BLOCKS DIREC_90 DIREC_180 DIREC_270 DIREC_360  DEGREES DIREC_LEFT DIREC_RIGHT DIREC_AROUND
//CONJUNCTIONS AND GRAMMAR
%token COMMA PERIOD QUEST EXCLA CONJ_THEN CONJ_ALSO CONJ_AND EOL OTHER

%start INPUT

%%

/* Reglas de la Gramática Adaptada */
INPUT : 					INPUT EOL 									{
																		//printf("TOKEN: NO INPUT\n");
																		set = 0;  
																	}
            					| INPUT SENTENCE 							{
																		//printf("TOKEN: SENTENCE INPUT\n");
																		set=1;  
																		result(); 
																	}
	    					| INPUT error EOL 								{
																		//printf("TOKEN: ERROR INPUT\n");
																		set=0;
																		result();
																		verify = 0;		
																	}
						| /* Espacio en blanco */
            					;
SENTENCE : 				NOUN_PHRASE VERB_PHRASE 					/*{
																		printf("TOKEN: SENTENCE\n"); 
																	}*/
            					;
VERB_PHRASE : 			VERB SIGN									/*{
																		printf("TOKEN: VERB_PHRASE\n"); 
																	}*/
    						| VERB CONJ_PHRASE  							/*{
																		printf("TOKEN: VERB_PHRASE\n"); 
																	}*/
            					;
NOUN_PHRASE : 			ROBOT ASK 									/*{
																		printf("TOKEN: CMPLX_NOUN\n"); 
																	}*/
    						| ROBOT COMMA ASK 							/*{
																		printf("TOKEN: CMPLX_NOUN\n"); 
																	}*/
            					;
ASK : 					KINDLY ASKING 								{
																		//printf("TOKEN: ASK\n");
																		appendToDescription("Thanks for being so nice with me!\n"); 
																	}
         					| ASKING 									{
																		//printf("TOKEN: ASK\n");
																		appendToDescription("Thanks for asking properly.\n");
																	}
	 					| PETITION KINDLY ASKING 						{
																		//printf("TOKEN: ASK\n");
																		appendToDescription("Thanks for being so nice with your petition!\n");
																	}
	 					| PETITION ASKING 							{
																		//printf("TOKEN: ASK\n");
																		appendToDescription("Thanks for giving me your petition so nicely!\n");
																	}
            					;
VERB : 					MOVING 										/*{
																		printf("TOKEN: VERB\n"); 
																	}*/
    						| TURNING 									/*{
																		printf("TOKEN: VERB\n"); 
																	}*/
						| PROJECTING 								/*{
																		printf("TOKEN: VERB\n"); 
																	}*/
            					;
PROJECTING :			PROJECT 									{
																		//printf("TOKEN: PROJECTING\n"); 
																		projecting_lock = 1;
																	}
            					;
MOVING : 				MOVE BLOCKS 								{
																		//printf("TOKEN: MOVING\n"); 
																		save("MOV, ", set); 
																	}
		 				| MOVE 										{ 
																		//printf("TOKEN: MOVING\n");
																		save("MOV, ", 1); 
																	}
						| MOVE BACK 								{
																		//printf("TOKEN: MOVING\n");
																		save("TURN, ", 180); 
																		save("MOV, ", 1); 
																		save("TURN, ", 180); 
																	}
						| MOVE BLOCKS BACK 							{
																		//printf("TOKEN: MOVING\n"); 
																		save("TURN, ", 180); 
																		save("MOV, ", set); 
																		save("TURN, ", 180); 
																	}
						| MOVE BACK BLOCKS 							{
																		//printf("TOKEN: MOVING\n"); 
																		save("TURN, ", 180); 
																		save("MOV, ", set); 
																		save("TURN, ", 180); 
																	}
						| MOVE FRONT 								{
																		//printf("TOKEN: MOVING\n");
																		save("MOV, ", 1);
																	}
						| MOVE BLOCKS FRONT 						{
																		//printf("TOKEN: MOVING\n");
																		save("MOV, ", set); 
																	}
						| MOVE FRONT BLOCKS 						{
																		//printf("TOKEN: MOVING\n");
																		save("MOV, ", set); 
																	}
            					;
TURNING : 				TURN DIRECTION 								/*{ 
																		printf("TOKEN: TURNING\n"); 
																	}*/ 
		   				| TURN 										{
																		//printf("TOKEN: TURNING\n");
																		save("TURN, ", 90);
																	}
            					;
BLOCKS : 				SINGLE SING_BLOCKS 							{
																		//printf("TOKEN: BLOCKS\n");
																		set = 1;
																	}
						| NUM PLU_BLOCKS 							{ 
																		//printf("TOKEN: BLOCKS\n");
																		set = $1; 
																	}
						| SINGLE 									{
																		//printf("TOKEN: BLOCKS\n");
																		set = 1;
																	}
						| NUM 										{
																		//printf("TOKEN: BLOCKS\n");
																		set = $1;
																	}
            					;
DIRECTION : 				DIREC_RIGHT 								{ 
																		//printf("TOKEN: DIREC_RIGHT\n");
																		save("TURN, ", 90);
																	} 
		     				| DIREC_AROUND 								{
																		//printf("TOKEN: DIREC_AROUND\n");
																		save("TURN, ", 180);
																	}
		     				| DIREC_LEFT 									{
																		//printf("TOKEN: DIREC_LEFT\n");
																		save("TURN, ", 270); 
																	}
						| DIREC_90 DEGREES 							{
																		//printf("TOKEN: DIREC_RIGHT\n");
																		save("TURN, ", 90);
																	} 
						| DIREC_180 DEGREES 							{
																		//printf("TOKEN: DIREC_RIGHT\n");
																		save("TURN, ", 180);
																	}
						| DIREC_270 DEGREES 							{
																		//printf("TOKEN: DIREC_LEFT\n");
																		save("TURN, ", 270); 
																	}
						| DIREC_360 DEGREES 							{
																		//printf("TOKEN: DIREC_LEFT\n");
																		save("TURN, ", 360);
																	}
            					;
CONJ_PHRASE: 			COMMA CONJ_THEN VERB_PHRASE 				/*{
																		printf("TOKEN: CONJ_THEN\n");
																	}*/
						| COMMA CONJ_AND VERB_PHRASE 				/*{
																		printf("TOKEN: CONJ_AND\n");
																	}*/
						| COMMA CONJ_AND CONJ_THEN VERB_PHRASE 	/*{
																		printf("TOKEN: CONJ_AND CONJ_THEN\n");
																	}*/
						| SIGN CONJ_ALSO COMMA ASK VERB_PHRASE 	/*{
																		printf("TOKEN: CONJ_ALSO ASK\n");
																	}*/
						| SIGN CONJ_ALSO COMMA VERB_PHRASE 		/*{
																		printf("TOKEN: CONJ_ALSO\n");
																	}*/
						| COMMA VERB_PHRASE 						/*{
																		printf("TOKEN: CONJ_PHRASE\n");
																	}*/
            					;
SIGN :					PERIOD 										/*{
																		printf("TOKEN: SIGN\n");
																	}*/
						| EXCLA 										/*{
																		printf("TOKEN: SIGN\n");
																	}*/
						| QUEST 										/*{
																		printf("TOKEN: SIGN\n");
																	}*/
            					;

%%

/* 	ERRORES GENERADOS     */ 

void yyerror(const char *s) { }

void clear(){
	// Clear the terminal screen
	#ifdef _WIN32
        	system("cls");
	#else
		system("clear");
	#endif
}

void allocation(){
	// Allocate initial memory for the sentence and descriptions
	fullSentence = (char *)malloc(1024 * sizeof(char));
	description = (char *)malloc(1024 * sizeof(char));
	instructions = (char *)malloc(1024 * sizeof(char));
	if (fullSentence == NULL) {
		perror("Failed to allocate memory");
           	exit(1);
	}
	fullSentence[0] = '\0'; // Initialize to an empty string
	if (description == NULL) {
		perror("Failed to allocate memory");
		exit(1);
	}
	description[0] = '\0'; // Initialize to an empty string
	if (instructions == NULL) {
		perror("Failed to allocate memory");
		exit(1);
	}
	instructions[0] = '\0'; // Initialize to an empty string
}

// Signal Handler Function
void handle_sigint() {
	// Free the allocated memory
    	free(fullSentence);
    	fullSentence = NULL;
	free(description);
	description = NULL;
	free(instructions);
	instructions = NULL;
	printf("\033[1;32m\nMemory freed.\033[1;0m\n");
	printf("\033[1;36mExiting... Thanks for using Gilbert!\033[1;0m\n\n");
	exit(0);
}

void interaction(){
	clear();
	title();
	printf("\033[1;36mWould you like to read action logs? Enter '1' for yes, or any other symbol for no: \033[1;0m");
	scanf("%9s", choice);
	if (strcmp(choice, "1") == 0) {
		logs = 1;
		printf("\033[1;32mI will show logs... \033[1;0m\n\n");
	}
	else {
		printf("\033[1;31mI will not show logs... \033[1;0m\n\n");
	}
	printf("\033[1;36mEnter '1' to read from 'instructions.txt', '2' to read from the terminal, or any other symbol to exit the program: \033[1;0m");
	scanf("%9s", choice);
	if (strcmp(choice, "1") == 0) {
		allocation();
		clear();
		title();
		fd = fopen("instructions.txt", "r");
		printf("\033[1;33mReading from file... Wait a moment:\033[1;0m\n\n\n");
	        if (!fd) {
			perror("Error opening file");
			exit (-1);
	        }
	        yyin = fd; // Set yyin to read from the file
	} else if (strcmp(choice, "2") == 0) {
    		// Register the signal handler
    		signal(SIGINT, handle_sigint);
		allocation();
		clear();
		title();
		printing = 0;	        
		printf("\033[1;36m\nTo end the program up, use \"CTRL + C\"\n\033[1;0m\033[1;32mReading from terminal. Enter your input:\033[1;0m\n\n\n");
	        yyin = stdin; // Set yyin to read from standard input (terminal)
	} else {
	        printf("\033[1;36mExiting... Thanks for using Gilbert!\033[1;0m\n\n");
	        exit(0); 	
	}
	file = fopen("instructions.asm", "w");
	yyparse();
	if (set == 0 && verify == 1){
		result(); // Se pone este comparador ya que al finalizar todas las reglas, YACC es incapaz de devolver la regla para un error. (SOLO SE USA EN CASO DE QUE EL USUARIO USE EL ARCHIVO 'instruction.txt')
	}
    	if (fd != NULL) {
        	fclose(fd);  // Cerrar el archivo si está abierto
    	}
}


/* 	PROGRAMA PRINCIPAL     */ 
int main() {
	interaction();
	// Free the allocated memory
    	free(fullSentence);
    	fullSentence = NULL;
	free(description);
	description = NULL;
	free(instructions);
	instructions = NULL;
	printf("\033[1;32mMemory freed.\033[1;0m\n");
	printf("\033[1;36mExiting... Thanks for using Gilbert!\033[1;0m\n\n");
	return 0;
}