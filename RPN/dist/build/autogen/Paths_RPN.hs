module Paths_RPN (
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
libdir     = "/Users/julien/.cabal/lib/RPN-0.1.0.0/ghc-7.4.2"
datadir    = "/Users/julien/.cabal/share/RPN-0.1.0.0"
libexecdir = "/Users/julien/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "RPN_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "RPN_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "RPN_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "RPN_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
