/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ROBOT = 258,                   /* ROBOT  */
    PETITION = 259,                /* PETITION  */
    KINDLY = 260,                  /* KINDLY  */
    ASKING = 261,                  /* ASKING  */
    MOVE = 262,                    /* MOVE  */
    PROJECT = 263,                 /* PROJECT  */
    TURN = 264,                    /* TURN  */
    FRONT = 265,                   /* FRONT  */
    BACK = 266,                    /* BACK  */
    SINGLE = 267,                  /* SINGLE  */
    NUM = 268,                     /* NUM  */
    PLU_BLOCKS = 269,              /* PLU_BLOCKS  */
    SING_BLOCKS = 270,             /* SING_BLOCKS  */
    DIREC_90 = 271,                /* DIREC_90  */
    DIREC_180 = 272,               /* DIREC_180  */
    DIREC_270 = 273,               /* DIREC_270  */
    DIREC_360 = 274,               /* DIREC_360  */
    DEGREES = 275,                 /* DEGREES  */
    DIREC_LEFT = 276,              /* DIREC_LEFT  */
    DIREC_RIGHT = 277,             /* DIREC_RIGHT  */
    DIREC_AROUND = 278,            /* DIREC_AROUND  */
    COMMA = 279,                   /* COMMA  */
    PERIOD = 280,                  /* PERIOD  */
    QUEST = 281,                   /* QUEST  */
    EXCLA = 282,                   /* EXCLA  */
    CONJ_THEN = 283,               /* CONJ_THEN  */
    CONJ_ALSO = 284,               /* CONJ_ALSO  */
    CONJ_AND = 285,                /* CONJ_AND  */
    EOL = 286,                     /* EOL  */
    OTHER = 287                    /* OTHER  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define ROBOT 258
#define PETITION 259
#define KINDLY 260
#define ASKING 261
#define MOVE 262
#define PROJECT 263
#define TURN 264
#define FRONT 265
#define BACK 266
#define SINGLE 267
#define NUM 268
#define PLU_BLOCKS 269
#define SING_BLOCKS 270
#define DIREC_90 271
#define DIREC_180 272
#define DIREC_270 273
#define DIREC_360 274
#define DEGREES 275
#define DIREC_LEFT 276
#define DIREC_RIGHT 277
#define DIREC_AROUND 278
#define COMMA 279
#define PERIOD 280
#define QUEST 281
#define EXCLA 282
#define CONJ_THEN 283
#define CONJ_ALSO 284
#define CONJ_AND 285
#define EOL 286
#define OTHER 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
