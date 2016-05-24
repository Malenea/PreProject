CC		:= gcc

CFLAGS		+= -O2 -Wno-unused-parameter -Wno-sign-compare

DFLAGS		:= -g3 -W -Wall -Wextra -Werror

LDFLAGS		+= -lpthread

RM		:= rm -rf

NAME		:= my_binary

DEBUG		:= my_binary_debug

HEADER_PATH	:= include/

SRCS_P		:= srcs/

COMM_SRCS_P	:= $(SRCS_P)common/

COMM_MSGS_P	:= $(COMM_SRCS_P)msgs/

OBJS_P		:= $(SRCS_P)objs/

COMM_OBJS_P	:= $(COMM_SRCS_P)objs/

SRCS		:= $(SRCS_P)main.c

COMM_SRCS	:= $(COMM_MSGS_P)trace.c\
		   $(COMM_MSGS_P)usage.c

TMP		:= main.o

COMM_TMP	:= trace.o\
		   usage.o

OBJS		:= $(OBJS_P)main.o

COMM_OBJS	:= $(COMM_OBJS_P)trace.o\
		   $(COMM_OBJS_P)usage.o

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 6`
bold=`tput bold`
uline=`tput smul`
reset=`tput sgr0`

all: 		$(NAME)

$(NAME):
		@echo "${bold}${green}Compiling binary${reset}"
		@if [ -d "./srcs/objs" ]; then \
		echo "${red}server objs exists, proceeding with make${reset}"; else \
		mkdir "./srcs/objs"; \
		fi
		@if [ -d "./srcs/common/objs" ]; then \
		echo "${red}common objs exists, proceeding with make${reset}"; else \
		mkdir "./srcs/common/objs"; \
		fi
		@echo "${green}======================================================================${reset}"
		$(CC) -c $(SRCS) $(COMM_SRCS) $(CFLAGS) -I$(HEADER_PATH)
		@mv $(TMP) $(OBJS_P)
		@mv $(COMM_TMP) $(COMM_OBJS_P)
		$(CC) -o $(NAME) $(OBJS) $(COMM_OBJS) $(LDFLAGS)
		@echo "${green}======================================================================${reset}"

debug:		$(DEBUG)

$(DEBUG):
		@echo "${bold}${green}Compiling debug binary all warnings treated as errors${reset}"
		@if [ -d "./srcs/objs" ]; then \
		echo "${red}server objs exists, proceeding with make${reset}"; else \
		mkdir "./srcs/objs"; \
		fi
		@if [ -d "./srcs/common/objs" ]; then \
		echo "${red}common objs exists, proceeding with make${reset}"; else \
		mkdir "./srcs/common/objs"; \
		fi
		@echo "${green}======================================================================${reset}"
		$(CC) -c $(SRCS) $(COMM_SRCS) $(CFLAGS) -I$(HEADER_PATH)
		@mv $(TMP) $(OBJS_P)
		@mv $(COMM_TMP) $(COMM_OBJS_P)
		$(CC) -o $(DEBUG) $(OBJS) $(COMM_OBJS) $(LDFLAGS) $(DFLAGS)
		@echo "${green}======================================================================${reset}"

clean:
		@echo "${blue}Cleaning objects .o${reset}";
		@$(RM) $(OBJS) $(COMM_OBJS)
		@if [ -d "./srcs/common/objs" ]; then \
		rm -rf "./srcs/common/objs"; else \
		echo "${red}common objs not found, proceeding${reset}"; \
		fi
		@if [ -d "./srcs/objs" ]; then \
		rm -rf "./srcs/objs"; else \
		echo "${red}objs not found, proceeding${reset}"; \
		fi
		@echo "${blue}Cleaning temporary objects ~ and #${reset}";
		@echo "${blue}======================================================================${reset}"
		@find . -name '*~' -print -delete -o -name '#*#' -print -delete
		@echo "${blue}======================================================================${reset}"

fclean:		clean
		@echo "${blue}Cleaning objects binary${reset}";
		@$(RM) $(NAME)

debugclean:	clean
		@echo "${blue}Cleaning objects binary${reset}";
		@$(RM) $(DEBUG)

re: 		fclean all

red:		debugclean debug

.PHONY: 	all debug clean flcean debugclean re red
