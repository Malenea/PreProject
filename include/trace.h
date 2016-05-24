#ifndef		_MSGS_H_
# define	_MSGS_H_

# include	<stdio.h>
# include	<stdarg.h>
# include	<errno.h>

# define	RESET_COLOR	"\e[0m"
# define	MAKE_GREEN	"\e[1;32m"
# define	MAKE_RED	"\e[1;31m"
# define	MAKE_YELLOW	"\e[1;33m"

# define	ERR		("ERROR")
# define	WARN		("WARNING")
# define	TRACE		("TRACE")

int		my_trace(int, char *, char *, ...);

# define	MI_ERROR(_rc, _format, ...)	mi_trace(_rc, ERR,	\
							 #_format,	\
							 ## __VA_ARGS__)
# define	MI_WARN(_format, ...)		mi_trace(0, WARN,	\
							 #_format,	\
							 ## __VA_ARGS__)
# define	MI_TRACE(_format, ...)		mi_trace(0, TRACE,	\
							 #_format,	\
							 ## __VA_ARGS__)

#endif		/* _MSGS_H_ */
