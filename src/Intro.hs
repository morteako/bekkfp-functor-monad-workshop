{-# LANGUAGE KindSignatures #-}

module Intro where



-- | Compute Fibonacci numbers
--
-- Examples:
--
-- >>> fib 10
-- 55
--
-- >>> fib 5
-- 5
fib :: Int -> Int
fib = error "TODO"

data RemoteData e a
  = NotAsked
  | Loading
  | Failure e
  | Success a
  

-- | implementer Show
-- >>> show NotAsked
-- "NotAsked"
-- >>> show (Failure 0)
-- "Failure 0"

instance (Show e,Show a) => Show (RemoteData e a) where
  show = error "TODO"

-- | implementer Eq
-- >>> Loading == Loading
-- True
-- >>> NotAsked == Failure "hei"
-- False

instance (Eq e, Eq a) => Eq (RemoteData e a) where
  (==) = error "TODO"


--Lag en type class for "containers/collections"
-- som kan ha 0 eller flere elementer

class Container (f :: * -> *) where

instance Container [] where

instance Container Maybe where

-- | en funksjon som heter isEmpty som gir true eller false
-- >>> isEmpty [1,2,3]
-- False
-- >>> isEmpty []
-- True
-- >>> isEmpty (Just 1)
-- False


-- | en funksjon first som gir første element, hvis det finnes, wrappet i en maybe 
-- >>> first [1,2,3]
-- Just 1
-- >>> first []
-- Nothing
-- >>> first (Just 1)
-- Just 1

