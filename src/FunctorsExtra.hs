{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE InstanceSigs #-}


module FunctorsExtra where
data State s a = State (s -> (a, s))

instance Functor (State s) where
  fmap :: forall a b . (a -> b) -> State s a -> State s b
  fmap f (State s) = State (fg . s)
      where
        fg :: (a,s) -> (b,s)
        fg (a,s) = (f a, s) 


-- sfmap :: forall a b s. (a -> b) -> State s a -> State s b
-- sfmap f (State s) = State (fg . s)
--     where
--       fg :: (a,s) -> (b,s)
--       fg (a,s) = (f a, s) 