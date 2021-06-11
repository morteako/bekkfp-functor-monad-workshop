module Intro where

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

-- | implementer Eq
-- >>> Loading == Loading
-- True
-- >>> NotAsked == Failure "hei"
-- False


--Lag en type class for "containers/collections" som kan ha 0 eller flere elementer


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

