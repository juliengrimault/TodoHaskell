module Paths_Heathrow (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/julien/.cabal/bin"
libdir     = "/Users/julien/.cabal/lib/Heathrow-0.1.0.0/ghc-7.4.2"
datadir    = "/Users/julien/.cabal/share/Heathrow-0.1.0.0"
libexecdir = "/Users/julien/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "Heathrow_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Heathrow_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Heathrow_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Heathrow_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
