{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE KindSignatures #-}

module Functors where

import Prelude hiding (fmap)


class MyFunctor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b

instance MyFunctor [] where
  fmap :: (a -> b) -> [a] -> [b]
  fmap f [] = []
  fmap f (x:xs) = f x : fmap f xs

-- | OPPGAVE : implementer MyFunctor Maybe
-- >>> fmap (+1) (Just 1)
-- Just 2
instance MyFunctor Maybe where
  -- fmap :: Fyll inn og fjern kommentar
  fmap = error "TODO"

data OneOrTwo a = One a | Two a a
  deriving (Show)

-- | OPPGAVE : implementer MyFunctor OneOrTwo
-- >>> fmap (+1) (Two 1 2)
-- Two 2 3
-- >>> fmap id (One 1)
-- One 1
data RemoteData e a
  = NotAsked
  | Loading
  | Failure e
  | Success a
  deriving (Show)

-- | OPPGAVE : implementer MyFunctor for RemoteData
-- >>> fmap reverse (Success "ABC")
-- Success "CBA"
-- >>> fmap reverse NotAsked
-- NotAsked

instance MyFunctor (RemoteData e) where
  fmap = error "todo"


-- | OPPGAVE : bruk det du har lært om functors til å gjøre om dataStuff til det som står i testen.
-- det finnes allerede even :: Int -> Bool
-- >>> dataStuffIsEven
-- [NotAsked,Loading,Failure "Gikk galt",Success True]

dataStuff :: [RemoteData String Int]
dataStuff =
  [ NotAsked,
    Loading,
    Failure "Gikk galt",
    Success 0
  ]

dataStuffIsEven :: [RemoteData String Bool]
dataStuffIsEven = fmap (fmap even) dataStuff