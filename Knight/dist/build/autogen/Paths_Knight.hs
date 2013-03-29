module Paths_Knight (
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
libdir     = "/Users/julien/.cabal/lib/Knight-0.1.0.0/ghc-7.4.2"
datadir    = "/Users/julien/.cabal/share/Knight-0.1.0.0"
libexecdir = "/Users/julien/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "Knight_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Knight_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Knight_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Knight_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
