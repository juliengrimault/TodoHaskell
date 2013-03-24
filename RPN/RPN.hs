import System.Environment
import System.IO
import Data.List

main = do
    args <- getArgs
    let result = solveRPN (head args)
    putStrLn ("result is: " ++ show result)


solveRPN :: String -> Float
solveRPN = head . foldl foldingFunction [] . words  
    where foldingFunction (x:y:rest) "*" = (x * y):rest
          foldingFunction (x:y:rest) "+" = (x + y):rest
          foldingFunction (x:y:rest) "-" = (x - y):rest
          foldingFunction (x:y:rest) "/" = (x / y):rest
          foldingFunction (x:y:rest) "^" = (x ** y):rest
          foldingFunction (x:rest) "ln" = log x:rest
          foldingFunction stack "sum" = [sum stack]
          foldingFunction stack numberString =  read numberString:stack
