import Control.Monad
import Data.List;

type ChessPosition = (Int, Int)
type Path = [ChessPosition]

knightNextMove :: ChessPosition -> [ChessPosition]
knightNextMove (c,r) = let positions = [(c + 2, r + 1), (c + 2, r - 1), (c - 2, r + 1), (c - 2, r -1),
                                        (c + 1, r + 2), (c + 1, r - 2), (c -1, r + 2), (c - 1, r - 2)]
                       in filter onBoard positions
                       where onBoard (c',r') = c' `elem` [1..8] && r' `elem` [1..8]


knightPositionAfter :: Int -> ChessPosition -> [ChessPosition]
knightPositionAfter 0 pos = [pos]
knightPositionAfter n pos = (knightNextMove pos) >>= knightPositionAfter (n - 1)

knightPathAfter :: Int -> Path -> [Path]
knightPathAfter 0 path = [path]
knightPathAfter n path@(x:xs) = (map (:path) (knightNextMove x)) >>= knightPathAfter (n - 1)


canReachIn :: Int -> ChessPosition -> ChessPosition -> Bool
canReachIn n start end = end `elem` (knightPositionAfter n start)

pathToPosition :: Int -> ChessPosition -> ChessPosition -> Maybe [ChessPosition]
pathToPosition n start end = let paths = knightPathAfter n [start]
                                 maybeIndex = findIndex (\(x:xs) -> x == end) paths
                             in fmap reverse (fmap (paths !!) maybeIndex)
