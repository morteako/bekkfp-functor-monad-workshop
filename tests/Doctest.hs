import System.Environment (getArgs)
import Test.DocTest

main :: IO ()
main = do
  doctest ["-isrc", "src"]