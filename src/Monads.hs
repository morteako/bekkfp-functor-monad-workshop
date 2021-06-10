{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE InstanceSigs #-}

module Monads where

import Data.Function
import Functors
import Prelude hiding (return)
import qualified Prelude

class MyFunctor m => MyMonad (m :: * -> *) where
  andThen :: (a -> m b) -> m a -> m b
  return :: a -> m a

-- | Oppgave : implementer MyMonad-instance for Maybe (prøv uten å se på slides først)
-- >>> andThen checkIfEven (Right 3)
-- Right 3
-- >>> andThen checkIfOdd (Right 3)
-- Left "Not odd"
checkIfOdd :: Int -> Either String Int
checkIfOdd x = if odd x then Right x else Left "Not odd"

-- | Oppgave : implementer MyMonad-instance for Either
-- >>> andThen checkIfOdd (return 3)
-- Right 3
-- >>> andThen checkIfOdd (return 3)
-- Left "Not odd"

--En type som bare wrappere en verdi
--identitetsfunksjonen som en datatype, på en måte
data Identity a = Identity a deriving (Show)

instance MyFunctor Identity where
    fmap f (Identity a) = Identity (f a)

-- | Oppgave : implementer MyMonad-instance for Identity
-- | Tips : Følg typene! Eller tenk på den som Maybe uten Nothing-case 
-- >>> andThen (\x -> Identity (x+x) (return 3)
-- Right 3

-- definert i Functors.hs
-- data RemoteData e a
--   = NotAsked
--   | Loading
--   | Failure e
--   | Success a
--   deriving (Show)

-- | Oppgave : implementer MyMonad-instance for RemoteData

-- | Oppgave : lag et eksempel som viser bruk av andThen, return og fmap for RemoteData





