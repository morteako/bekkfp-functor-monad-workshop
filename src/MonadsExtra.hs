module MonadsExtra where

import FunctorsExtra

-- Ignorer det her
instance Applicative (State s) where
    pure = undefined
    (<*>) = undefined

--oppgave : Lag Monad-instance
instance Monad (State s) where
    (>>=) = undefined -- se MonadsDo.hs
    return = undefined

data Func a b = Func (a -> b)

--oppgave : Lag functor- og monadinstance for Func a

instance Functor (Func a) where
    fmap = undefined

-- ignorer 
instance Applicative (Func a) where
    pure = undefined
    (<*>) = undefined 

instance Monad (Func a) where
  return = undefined
  (>>=) = undefined
