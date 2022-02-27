from pyswip import Prolog

prolog = Prolog()
prolog.consult("prolog.pl")

print(list(prolog.query("aprobar_linea_credito(juan, 2, 10)")))


