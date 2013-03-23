import System.Environment
import System.Directory
import System.IO
import Data.List

main = do
    (command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action args


dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add),
            ("view", view),
            ("remove", remove)]

add :: [String] -> IO ()
add [] = putStrLn "No file specified..."
add (fileName:[]) = putStrLn "No item to add..."
add (fileName:items) = appendFile fileName (unlines items)

view :: [String] -> IO ()
view [] = putStrLn "No file specified..."
view (fileName:_) = do
    content <- readFile fileName
    let todoTasks = lines content
        numberedTasks = zipWith (\n item -> show n ++ "-" ++ item) [0..] todoTasks
    putStrLn (unlines numberedTasks)

remove :: [String] -> IO ()
remove [] = putStrLn "No file specified..."
remove (fileName:[]) = putStrLn "No item number to remove..."
remove [fileName,indexToRemove] = do
    content <- readFile fileName
    (tempFileName, tempHandle) <- openTempFile "." "temp_list"

    let items = lines content
        index = read indexToRemove
        newItems = delete (items !! index) items

    hPutStr tempHandle (unlines newItems)
    hClose tempHandle
    removeFile fileName
    renameFile tempFileName fileName
