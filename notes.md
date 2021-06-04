Intro:

($)

Type classes
hvorfor, hvordan, Hva

vanlige
typesignaturer =>
superklasser

Typer
kinds
higher kinded types
type class med higher kinded type


Hva?


Eksempler på map-funksjoner

Hva vil vi?

Hva forventer vi av en map?
Mappe en funksjon som ikke gjør noe returnerer samme verdi
Mappe flere ganger er samme som en gang

Generaliserer

Functor
løfte en funksjon inn i "f" 
fra (a -> b) til (f a -> f b)

implementere functor

Maybe
Either
List

Identity
State
Const
Tuple
->

Composable
Product?

Hvorfor generalisere?
fmap => mindre refaktorering
kan skrive generelle funksjoner (feks <$)
parametricity => Functor f sier mye mer enn Model/DataType
kan også gi opphav til implementasjson av lenses : forall f. Functor f => (a -> f b) -> s -> f t

DeriveFunctor

---------------
Monad
eksempler på 
bind osv Maybe - lookup function og så lookup result
flatMap 

generell join / flatten

(>=>)

replicateM
when
liftM2


