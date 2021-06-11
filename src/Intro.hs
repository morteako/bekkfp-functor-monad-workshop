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
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

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
  show NotAsked = "NotAsked"
  show Loading = "Loading"
  show (Failure e) = "Failure " ++ show e
  show (Success a) = "Success " ++ show a

-- | implementer Eq
-- >>> Loading == Loading
-- True
-- >>> NotAsked == Failure "hei"
-- False

instance (Eq e, Eq a) => Eq (RemoteData e a) where
  NotAsked == NotAsked = True
  Loading == Loading = True
  Failure e1 == Failure e2 = e1 == e2
  Success a1 == Success a2 = a1 == a2
  _ == _ = False


--Lag en type class for "containers/collections"
-- som kan ha 0 eller flere elementer

class Container f where
  isEmpty :: f a -> Bool 
  first :: f a -> Maybe a

instance Container [] where
  isEmpty [] = True
  isEmpty _ = False

  first [] = Nothing
  first (x:_) = Just x

instance Container Maybe where
  isEmpty Nothing = True
  isEmpty _ = False

  first = id

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

