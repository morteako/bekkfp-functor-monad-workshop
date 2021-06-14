module MonadsExtra where

import Functors
import FunctorsExtra
import Monads



--oppgave : Lag Monad-instance for State
instance MyMonad (State s) where
    andThen = error "todo"
    return = error "todo"


--oppgave : Lag functor- og monadinstance for funksjoner
-- a -> b
-- ((->) a b)

instance MyFunctor ((->) a) where
    fmap = error "todo"


instance MyMonad ((->) a) where
  andThen = error "todo"
  return = error "todo"
