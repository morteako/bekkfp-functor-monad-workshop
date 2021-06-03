import System.Environment (getArgs)
import Test.DocTest

main :: IO ()
main = doctest ["-isrc", "src/Main.hs"]