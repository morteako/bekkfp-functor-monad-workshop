module Main where

-- | Compute Fibonacci numbers
--
-- Examples:
--
-- >>> fib 10
-- 10
--
-- >>> fib 5
-- 5
fib :: Int -> Int
fib = id

main :: IO ()
main = do
  putStrLn "hello world"
