# bekkfp-functor-monad-workkshop


## Installering 

### clone repo 
`git clone https://github.com/morteako/bekkfp-functor-monad-workshop`

#### Må ha :
Stack - installer via 
`brew install stack` eller `curl -sSL https://get.haskellstack.org/ | sh`

#### Kjekt å ha :
ghcid - `stack install ghcid`

VS Code: 
* Haskell Syntax Highlighting
* Haskell extension - (ikke så farlig om det ikke funker, mye hjelp med rask repl fra ghcid)



### Sjekke at ting fungerer
Bygge og kjøre tester : `stack build --test`
(Kan ta litt tid, pga stack installer også riktig GHC-versjon)

Compile+run tests on save : `ghcid` 

Alternativ : `stack build --test --file-watch --fast`

## Repl 
`stack ghci`

### Replkommandoer 
:info <funksjon/type/type class> - for info
```
> :info Maybe
type Maybe :: * -> *
data Maybe a = Nothing | Just a

> :info Eq
type Eq :: * -> Constraint
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
```
:t <verdi/funksjon> - for å se typen
```
> :t show
show :: Show a => a -> String
```
:k <type> - for å se kinden til en type
```
> :k Either
Either :: * -> * -> *
```

:r - reloade filene

:browse <modul> - se definisjonene i en modul
```
> :bro FunctorsExtra
setValue :: Functor f => a -> f b -> f a
```
