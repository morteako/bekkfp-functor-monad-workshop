module Intro where

data RemoteData e a
  = NotAsked
  | Loading
  | Failure e
  | Success a

--implementer Show og Eq

--Lag en type class for "containers/collections" som kan ha 0 eller flere elementer
--en funksjon som heter isEmpty som sier true eller false
--en funksjon first som gir første element, hvis det finnes, wrappet i en maybe
