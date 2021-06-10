{-# LANGUAGE RankNTypes #-}

module FunctorsExtra where

-- | puts a value into the functor
-- >>> setValue 1 Nothing
-- Nothing
-- >>> setValue 1 (Just "hei")
-- Just 1
-- >>> setValue "a" [True,False]
-- ["a","a"]
setValue :: Functor f => a -> f b -> f a
setValue = undefined



data Identity a = Identity a

data Const a b = Const a

data Compose f g a = Compose (f (g a))

instance Functor Identity where
  fmap = error "TODO"

instance Functor (Const a) where
  fmap = error "TODO"

instance Functor (Compose f g) where
  fmap = error "TODO - trenger nok noen constraints"


data State s a = State (s -> (a, s))

instance Functor (State s) where
  fmap = error "TODO"

-- Veldig vanskelig

-- Lens stuff
type Lens s t a b = forall f. Functor f => (a -> f b) -> s -> f t

-- | Oppgave : implementer view . Her gjelder det å bruke riktig Functor
-- >>> view _1 ("hei",1)
-- "hei"
view :: Lens s s a a -> s -> a
view lens s = undefined

_1 :: Lens (a, c) (b, c) a b
_1 a2fb (a, c) = fmap (setBFirst (a, c)) fb
  where
    fb = a2fb a
    setBFirst (x, y) b = (b, y)

  
-- | Oppgave  : implementer _2 (samme som _1, bare for verdi nr 2)

_2 :: Lens s t a b --ikke riktig type
_2 =  undefined
  
