{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE InstanceSigs #-}

module Monads where

import Data.Function
import Functors
import Prelude hiding (return,fmap)
import qualified Prelude

class MyFunctor m => MyMonad (m :: * -> *) where
  andThen :: (a -> m b) -> m a -> m b
  return :: a -> m a

-- | Oppgave : implementer MyMonad-instance for Maybe (prøv uten å se på slides først)
instance MyMonad Maybe where
  andThen f Nothing = Nothing
  andThen f (Just a) = f a
  return = Just

checkIfOdd :: Int -> Either String Int
checkIfOdd x = if odd x then Right x else Left "Not odd"


instance MyFunctor (Either e) where
  fmap f (Left e) = Left e
  fmap f (Right a) = Right (f a)

instance MyMonad (Either e)  where
  andThen f (Left e) = Left e
  andThen f (Right a) = f a
  
  return = Right

-- | Oppgave : implementer MyMonad-instance for Either
-- >>> andThen checkIfOdd (return 3)
-- Right 3
-- >>> andThen checkIfOdd (return 4)
-- Left "Not odd"

--En type som bare wrappere en verdi
--identitetsfunksjonen som en datatype, på en måte
data Identity a = Identity a deriving (Show)

instance MyFunctor Identity where
    fmap f (Identity a) = Identity (f a)

-- | Oppgave : implementer MyMonad-instance for Identity
-- | Tips : Følg typene! Eller tenk på den som Maybe uten Nothing-case 
-- >>> andThen (\x -> Identity (x+x)) (return 3)
-- Identity 6

instance MyMonad Identity where
  andThen f (Identity a) = f a
  return = Identity

-- definert i Functors.hs
-- data RemoteData e a
--   = NotAsked
--   | Loading
--   | Failure e
--   | Success a
--   deriving (Show)

-- | Oppgave : implementer MyMonad-instance for RemoteData

-- | Oppgave : lag et eksempel som viser bruk av andThen, return og fmap for RemoteData


-- | implementer join (kan også kalles flatten)
-- følg typene
-- >>> join (Just (Just 2))
-- Just 2
-- >>> join (Right (Left 1))
-- Left 1
join :: MyMonad m => m (m a) -> m a
join = andThen id

-- | bonus : implementer andThen ved hjelp av join og fmap

andThenJoin :: MyMonad m => (a -> m b) -> m a -> m b
andThenJoin amb ma = join (fmap amb ma)
