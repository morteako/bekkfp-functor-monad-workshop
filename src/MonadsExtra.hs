module MonadsExtra where

import Functors
import FunctorsExtra
import Monads



--oppgave : Lag Monad-instance for State
instance MyMonad (State s) where
    andThen f (State fs) = State (\s -> let
        (a,s') = fs s
        State res = f a
        in res s')
    return a = State (\s -> (a,s))


--oppgave : Lag functor- og monadinstance for funksjoner
-- a -> b
-- ((->) a b)

instance MyFunctor ((->) a) where
    fmap = (.)


instance MyMonad ((->) a) where
  andThen = \f g a -> f (g a) a
  return = const
