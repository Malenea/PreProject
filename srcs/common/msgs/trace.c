#include	<stdlib.h>
#include	<string.h>
#include	<time.h>
#include	<fcntl.h>
#include	<unistd.h>
#include	<sys/stat.h>
#include	"trace.h"

void		print_type(int c, char *type)
{
  if ((strcmp(type, ERR)) == 0)
    {
      fprintf((c == 1 ? stdout : stderr),
	      MAKE_RED"[%s]"RESET_COLOR" : ", type);
      fflush((c == 1 ? stdout : stderr));
    }
  else if ((strcmp(type, WARN)) == 0)
    {
      fprintf((c == 1 ? stdout : stderr),
	      MAKE_YELLOW"[%s]"RESET_COLOR" : ", type);
      fflush((c == 1 ? stdout : stderr));
    }
  else
    {
      fprintf((c == 1 ? stdout : stderr),
	      MAKE_GREEN"[%s]"RESET_COLOR" : ", type);
      fflush((c == 1 ? stdout : stderr));
    }
}

int		print_errno(int c)
{
  if (errno != 0 && c != 1)
    {
      fprintf((c == 1 ? stdout : stderr), " : ");
      fflush((c == 1 ? stdout : stderr));
      fprintf((c == 1 ? stdout : stderr), MAKE_RED);
      perror("");
      fprintf((c == 1 ? stdout : stderr), RESET_COLOR);
      return (1);
    }
  return (0);
}

int		my_trace(int err, char *type, char *fmt, ...)
{
  va_list	args;
  time_t	curr_time;
  char		*c_time_str;
  int		c;

  c = ((strcmp(type, ERR) == 0) ? 2 : 1);
  curr_time = time(NULL);
  c_time_str = ctime(&curr_time);
  c_time_str[strlen(c_time_str) - 1] = 0;
  fprintf((c == 1 ? stdout : stderr),"[%s] ", c_time_str);
  fflush((c == 1 ? stdout : stderr));
  print_type(c, type);
  va_start(args, fmt);
  vfprintf((c == 1 ? stdout : stderr), fmt, args);
  va_end(args);
  if (print_errno(c) == 0)
    fprintf((c == 1 ? stdout : stderr), "\n");
  return (err);
}
