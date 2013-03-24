import System.Environment
import System.IO
import Data.List


main = do
    args <- getArgs
    putStrLn (show heathrowRoads)
    let optimalRoute = findRoute heathrowRoads
    putStrLn ("optimal route is :" ++ show optimalRoute)

type Top = Int
type Bottom = Int
type Cross = Int
data Section = Section { top :: Int , bottom :: Int , cross :: Int } deriving (Show)
type RoadSystem = [Section]
data Segment = Top | Bottom | Cross deriving (Show)
type Route = ([Segment],Int)


heathrowRoads :: RoadSystem
heathrowRoads = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]


findRoute :: [Section] -> Route
findRoute s = 
    let emptyRoute = ([],0)
        (topRoute, bottomRoute) = foldl routesToNextSection (emptyRoute,emptyRoute) s
    in if snd topRoute < snd bottomRoute
        then (reverse $ fst topRoute, snd topRoute)
        else (reverse $ fst bottomRoute, snd bottomRoute)

routesToNextSection :: (Route,Route) -> Section -> (Route,Route)
routesToNextSection r s = ((routeToNextTopSection r s), (routeToNextBottomSection r s))

routeToNextTopSection :: (Route, Route) -> Section -> Route
routeToNextTopSection ((topPath, topValue),(bottomPath, bottomValue)) s
    | topValue + (top s) < bottomValue + (bottom s) + (cross s) = ((Top:topPath), topValue + (top s))
    | otherwise = (Cross:Bottom:bottomPath, bottomValue + (bottom s) + (cross s))

routeToNextBottomSection :: (Route, Route) -> Section -> Route
routeToNextBottomSection ((topPath, topValue),(bottomPath, bottomValue)) s
    | topValue + (top s) + (cross s) < bottomValue + (bottom s) = (Cross:Top:topPath, topValue + (top s) + (cross s))
    | otherwise = (Bottom:bottomPath, bottomValue + (bottom s))
