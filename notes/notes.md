---
marp:true
marp: true
---
# Functors og Monads
## Plan
* Kort gjennomgang av Haskell-konsepter
* Functors
* Monads
---
## Haskell
* Type classes
* Typer og kinds
* Higher kinded types
---

## Type classes
* Haskell sin måte å ha forskjellige implementasjoner for forskjellige typer
    * Ad-hoc polymorfisme
* Ikke som en Class i feks Java  
* Ganske nærme et interface
* Noe som mangler i Elm

---
## Eksempel på en Type Class - Show
* Show er en type class for alle typer som har verdier kan gjøres om til en String
  * En slags serialisering
  * Litt som toString, bare ikke for alle typer (feks funksjoner)

```haskell

class Show a where
  show :: a -> String

-- Bool og Int implementerer Show
> show True
"True"
> show 1
"1"
```
---
# Type classes - typesignaturer
* At en funksjon krever at en type implementerer en type class har en egen syntax
```haskell
show :: Show a => a -> String
```
* Alt før => viser constraints
* her : Hvis en type implementer Show, kan man bruke show-funksjonen for å gjøre den om en verdi av den typen til en String

---
# Bruke type class-funksjoner i egne funksjoner
```haskell
showBoth :: (Show a,Show b) => a -> b -> String
showBoth a b = show a ++ show b

> showBoth 1 True
"1True"
```


---

# Type classes - Instances
## Hvordan implementere type classes
```haskell
--Implementere Show For Bool
instance Show Bool where
    show True = "True"
    show False = "False"

--For Maybe a
--Hvorfor trenger vi Show a her?
instance Show a => Show (Maybe a) where
    show Nothing = "Nothing"
    show (Just a) = "Just " ++ show a
```

---

## Eksempel 2 : Eq - for å sjekke likhet
```haskell
class Eq a => Ord a where
    (==) :: a -> a -> Bool

instance Eq Bool where
    True == True = True
    False == False = True
    _ == _ = False

instance Eq a => Eq [a] where
    [] == []
    (x:xs) == (y:ys) = x == y && xs == ys
    _ == _ False
```
---

## Superklasser
* Type classes kan ha superklasser
* Det betyr at man må ha en instance av superklassen for å kunne lage en instance av subklassen
```haskell
class Eq a => Ord a where
    (<=) :: a -> a -> Bool

--Det funker pga Bool har Eq instance
instance Ord Bool where
    True <= False = False
    _ <= _ = True

--Dette funker siden Ord a impliserer Eq a, siden Eq er superklasse
ordEq :: Ord a => a -> a -> Bool
ordEq a b = a == b
```
---

## Typer og kinds

* Verdier har en type 
    * "Hei" har typen String
    * True har typen Bool
* Men hva med Maybe? List?
  * Ingen verdier som har typen Maybe eller List
  * Når man gir Maybe og List typer som argumenter, feks Maybe Int og List Bool, da kan de ha verdier
* Maybe og List er typekonstruktører
* Disse kan klassifiser ved hjelp av kinds, et typesystem for typer

---

* Typer med verdier (vanlige typer) har kind *
    * Int :: *
    * Bool :: *
* Typekonstruktører som tar inn 1 argument har kind * -> *,  siden når man gir de en vanlig type, så kan de også ha verdier
    * Maybe :: * -> *
    * Maybe Int :: *
    * List :: * -> *
    * List Bool :: *
    * Maybe Maybe : Error
* Typekonstruktører som tar inn 2 argumenter har kind * -> * -> *
    * Either :: * -> * -> *  
    * Either Int :: * -> *   
    * Either Int String :: *
    * Tuple :: * -> * -> *
---
## Higher kinded types
---

hvorfor, hva
Interface ish
Elm




vanlige type classes og basic instances
typesignaturer =>
superklasser

Typer
kinds
higher kinded types
Typekonstruktører
Maybe, List

data IntContainer (f :: *  -> *) = IntContainer (f Int)

IntCointainer (Just 1) :: IntContainer Maybe
IntCointainer [1] :: IntContainer []

## Felles oppgaver


Hva?


Eksempler på map-funksjoner

```haskell
mapMaybe :: (a->b) -> Maybe a -> Maybe b
mapList :: (a -> b) -> List a -> List b
```


a -> b -> f a -> f b

type List a = []





Hva vil vi?

Hva forventer vi av en map?
Mappe en funksjon som ikke gjør noe returnerer samme verdi
Mappe flere ganger er samme som en gang




Generaliserer

Functor
løfte en funksjon opp/inn i "f" 
fra (a -> b) til (f a -> f b)
feks
(Int -> String) til [Int] -> [String]

oppgavene : implementere functor

--Maybe
Either
List

data Identity a = Identity a 
State
Const
Tuple
->

remoteData


setValue :: Functor f => b -> f a -> f b
setValue = undefined 

setValue "hei" [1,2] = ["hei","hei"]

range :: Int -> [Int]

kan man bruke kun fmap og range for å få [0,1,2] -> [0,1,2,3,4,546]?



Composable
Product?

Hvorfor generalisere?
fmap => mindre refaktorering
kan skrive generelle funksjoner (feks <$) 
parametricity => Functor f sier mye mer enn Model/DataType, ved å begrense
kan også gi opphav til implementasjson av lenses : forall f. Functor f => (a -> f b) -> s -> f t

DeriveFunctor

data S a = ... derive Functor


---------------
Monad
eksempler på 
bind osv >>= Maybe - lookup function og så lookup result
flatMap 
return

detaljer

Maybe
Either
List

IO
State


eksempler
generaliserte eksempler

generell join / flatten

(>=>)

prøve å finne noe kort og lurt og si om reglene

replicateM
when
liftM2

skrive map2,map3, andMap

do notation
