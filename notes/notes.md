---
marp:true
marp: true
---
<!-- paginate: true -->
# Functors og Monads
## Plan
* Kort gjennomgang av Haskell-konsepter
* Functors
* Monads
---
# Vanskelig tema 
* Lærer forskjellig
* Abstrakt
* Alternative fremgangsmåter
* Forskjellige læringsmåter
* Noe som blir sagt kan være liltt upresist for å slippe detaljer

---
## Haskell
* Snakker litt om konsepter i Haskell. Generelt, ikke spesifikt for Functors og Monads. 
    * Universielle konsepter

* Superkort syntaksintro
* Type classes
* Typer og kinds
* Higher kinded types

---

# Syntaks

* Mye likt som Elm
    * Elm-syntaks er ca et subset av Haskell-syntaks

```haskell
funksjonsNavn :: a -> Maybe a
funksjonsNavn aVal = Just aVal
```
* en funksjon med navn funksjonsNavn
* øverste linjen er en typedefinisjon, som sier hvilken type det er
    * trengs som regel ikke pga type inference, men er ofte hjelpsomt
* Generisk type a
  * Generiske typer har små bokstaver. Konkrete typer store
* -> sier at det er en funksjon
    * tar inn en a og gir tilbake en Maybe a
* aVal er navnet på argumentet
* Just aVal er returverdien

---

# Funksjon med flere definisjoner

## Man kan definere funksjoner en gang per case
```haskell
not :: Bool -> Bool
not True = False
not False = True
```
## Man har også case (som i Elm)
```haskell
not :: Bool -> Bool
not b = case b of
    True -> False
    False -> True
```

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
class Eq a where
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
* Så alle typer som er Ord er også Eq
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
* Higher kinded types ~ higher order functions

---
* Typer med verdier (vanlige typer) har kind *
    * Int :: *
    * Bool :: *
* Typekonstruktører som tar inn 1 argument har kind * -> *,  siden når man gir de en vanlig type, så kan de også ha verdier
    * Maybe :: * -> *
    * Maybe Int :: *
    * List :: * -> *
    * List Bool :: *
    * Maybe Maybe - Error
* Typekonstruktører som tar inn 2 argumenter har kind * -> * -> *
    * Either :: * -> * -> *  
    * Either Int :: * -> *   
    * Either Int String :: *
    * Tuple :: * -> * -> *
---

## Higher kinded types

I Haskell kan man abstrahere og bruke higher kinded types.
Feks i egne datatyper.

Her tar IntContainer inn en typekonstruktør med ett argument

```haskell
data IntContainer (f :: *  -> *) = IntContainer (f Int)

IntCointainer (Just 1) :: IntContainer Maybe
    siden Maybe har kind * -> *, så passer i IntContainer

IntCointainer [1] :: IntContainer List
    siden List har kind * -> *, så den passer også inn i IntContainer

--FUNKER IKKE
IntContainer "hei" :: IntCointainer String
    siden String har kind *, altså ikke en typekonstruktør, så passer den ikke inn og dette fungerer ikke 
```
---
## Eller i type classes
```haskell
class Summable (f :: * -> *) where
    sumInts :: f Int -> Int

instance Summable Maybe where
    sumInts Nothing = 0
    sumInts (Just x) = x

> sumInts (Just 3)
3

instance Summable List where
    sumInts [] = 0
    sumInts (x:xs) = x + sumInts xs

> sumInts [1,2,3,4,5]
15
```

---
## Felles oppgaver - Intro.hs

---
# Functors
## Typer som kan bli mappet over
---
## Functors
* Man vil ofte transformere data 
* Et standard eksempel er å mappe en funksjon over en liste
    * Deklarativt
    * Lettere å generalisere funksjon enn features i språket (loops)
* En generalisering av containers / boks
    * Den abstraksjonen blir nok strukket litt langt
---
```haskell
mapList :: (a->b) -> List a -> List b
mapList f [] = []
mapList f (x:xs) = f x : map f xs

> mapList not []
[]

> mapList not [True,False]
[False,True]
```

---
# Map - Maybe a


```haskell
mapMaybe :: (a->b) -> Maybe a -> Maybe b
mapMaybe f Nothing = Nothing
mapMaybe f (Just x) = Just (f x)

> mapMaybe show Nothing
Nothing

> mapMaybe show (Just 1)
Just "1"
```

---
# Map - Either e a


```haskell
mapEither :: (a->b) -> Either e a -> Either e a
mapEither f (Right a) = Right (f a)
mapEither f (Left e) = Left e

> mapEither (+1) (Left True)
Left True

> mapEither (+1) (Right 1)
Right 2
```

---
# Sammenligne map-funksjonene

```haskell
mapList :: (a -> b) -> List a -> List b
mapMaybe :: (a->b) -> Maybe a -> Maybe b
mapEither :: (a->b) -> Either e a -> Either e b
```
---
# Sammenligne map-funksjonene
## Litt formattering
```haskell
mapList     :: (a->b)   -> List         a -> List       b
mapMaybe    :: (a->b)   -> Maybe        a -> Maybe      b
mapEither   :: (a->b)   -> (Either e)   a -> (Either e) b
```
## Hvordan skal vi generalisere det her?
---
# Ser at det er en typekonstruktør

```haskell
mapList     :: (a->b)   -> List         a -> List       b
mapMaybe    :: (a->b)   -> Maybe        a -> Maybe      b
mapEither   :: (a->b)   -> (Either e)   a -> (Either e) b

mapGeneralized :: (a->b) -> f a -> f b
```
f er da en higher kinded type

---



---
## Lage en type class
Siden det er forskjellig implementasjon per type trenger vi en type class

```haskell
type class Functor (f :: * -> *) where
    fmap :: (a->b) -> f a -> f b
```

Man kan se det som at man løfter en funksjon til å jobbe på et høyere nivå.
Feks fra Int -> Int til Maybe Int -> Maybe Int

---


Instancene kan lages ved si at fmap = mapList eller mapMaybe osv. Eller man kan definere funksjonen i instancen

```haskell
instance Functor Maybe where
    fmap :: (a->b) -> Maybe a -> Maybe b
    fmap = mapMaybe
```

```haskell
instance Functor (Either e) where
    fmap :: (a->b) -> (Either e) a -> (Either e) b
    fmap f (Right a) = Right (f a)
    fmap f (Left e) = Left e
```
* Typesignaturen er ikke nødvendig, bare for å hjelpe
* (Either e) a er det samme som Either e a

---
# Lage funksjoner som funker for alle Functors
```haskell
mapAddOne :: Functor f => f Int -> f Int
mapAddOne = fmap (+1)

> mapAddOne (Just 1)
Just 2

> mapaddone [1,2,3]
[2,3,4]
```

I Elm så måtte vi ha laget en per Functor, altså
mapAddOneMaybe, mapAddOneList, mapAddOneEither osvosv

---

# Lage funksjoner som funker for alle Functors
```haskell
deepShow :: (Functor f, Functor g, Show a) => f (g a) -> f (g String)
deepShow = fmap (fmap show)

-- her er f List, g Maybe og a Int
> deepShow [Just 1, Nothing, Just 3]
[Just "1",Nothing,Just "3"]

-- her er f Maybe, g List og a Int
> deepShow (Just [1,2,3])
Just ["1","2","3"]
```
Uten en functor-typeclasse så måtte man skrevet en implementasjon av denne funksjonen per kombinasjon av to functorer

---

# Hvorfor generalisere?
* mindre endringer når man endrer typer
* kan skrive generelle funksjoner 
* parametricity => Functor f sier mye mer enn Model/DataType
    *  ved å begrense hva man kan gjøre er det lettere å forstå
    *  eksempel : a -> a sier mer enn Int -> Int
* kan også gi opphav til implementasjson av lenses : 
    * forall f. Functor f => (a -> f b) -> s -> f t
---

# Lover
## Hvordan forventer vi at en fmap-funksjon oppfører seg?
* Mappe en funksjon som ikke gjør noe returnerer samme verdi
    * fmap id x = x
    * id er identitetsfunksjonen, altså id a = a
* Mappe flere ganger er samme som en gang
    * fmap f (fmap g) x = fmap (f . g) x
    * Dette følger automatisk i Haskell av første regelen

---

## Lovlig og ulovlig functor instance
### Hvilken av disse functor instancene er lovlige/ulovlige og hvorfor?
```haskell
data Two a = Two a a

instance Functor Two where
    fmap f (Two a1 a2) = Two (f a1) (f a2) 

instance Functor Two where
    fmap f (Two a1 a2) = Two (f a1) (f a1)

instance Functor Two where
    fmap f (Two a1 a2) = Two (f a2) (f a1)
```
---

# Oppgaver


---------------


--- 

# Kombinere Maybe - eksempel

Vi vil ta første strengen, gjøre om til tall og gange med 10.
Da må vi ta hensyn til at ting kan feile (Maybe).
## Rett fram :
```haskell
safeHead :: [a] -> Maybe a
safeReadInt :: String -> Maybe Int

numstrs = ["3","2","3"]

maybeFirstInt = case safeHead numstrs of
    Nothing -> Nothing
    Just first -> case safeReadInt first of
        Nothing -> Nothing
        Jusst num -> Just (num*10)
```

--- 

# Kombinere Maybe - eksempel

Dette blir veldig klønete. Ser at det er et pattern og skriver finere

```haskell
andThen :: Maybe a -> (a -> Maybe b) -> Maybe b
andThen Nothing _ = Nothing
andTHen (Just a) f = f a

maybeFirstInt = 
    let
        first = safeHead numstrs
        num = andThen first safeRead
        times10 x = Just x
    in 
        andThen times10 num
```

Kan vi forenkle det her bittelitt? Hint hint : Functors

--- 
# Kombinere Maybe - eksempel


```haskell
andThen :: Maybe a -> (a -> Maybe b) -> Maybe b
andThen Nothing _ = Nothing
andTHen (Just a) f = f a

maybeFirstInt = 
    let
        first = safeHead numstrs
        num = andThen first safeRead
        times10 x = Just x
    in 
        andThen times10 num

-- vs bruke fmap

maybeFirstInt = 
    let
        first = safeHead numstrs
        num = andThen first safeRead
    in 
        fmap (*10) num
```

---

# Kombinere List
Gjøre noe lignende, bare for lister.
Vi vil for hvert tall telle opp fra 0 til tallet (3 -> [0,1,2,3]) og så replisere det tallet like mange ganger som seg selv (3 -> [3,3,3])

```haskell
replicateSelf :: Int -> [Int]
replicatesef x = replicate x x
countUp :: Int -> [Int]
countUp x = [0..x]

nums = [1,2,3]

vi ser at vi må ha en flatMap (andThen9
```

--- 
# Kombinere List - flatMap

```haskell
flatMap :: (a -> [b]) -> [a] -> [b]
flatMap f xs = concat (fmap f xs)
--concat er flatten, concat funker :: [[a]] -> [a]
```
--- 
# Kombinere List - flatMap

```haskell
replicateSelf :: Int -> [Int]
replicatesef x = replicate x x
countUp :: Int -> [Int]
countUp x = [0..x]

nums = [1,2,3]

countedAndReplicated = flatMap replicateSelf (flatMap countUp nums)
```

--- 


# Kombinere State

--- 

# Generalisere

--- 

# Monad

--- 

# Generelle funksjoner - join

--- 

# Generelle funksjoner - >>

--- 

# Do notation

--- 

# Do notation - eksempel

--- 

# A

--- 

# A



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


generalisering av ?.
list comprenhensions
async

Samme notasjon
