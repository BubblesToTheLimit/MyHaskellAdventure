module Paths_llvm_test (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0], versionTags = []}
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/scat666/.cabal/bin"
libdir     = "/home/scat666/.cabal/lib/i386-linux-ghc-7.6.3/llvm-test-0"
datadir    = "/home/scat666/.cabal/share/i386-linux-ghc-7.6.3/llvm-test-0"
libexecdir = "/home/scat666/.cabal/libexec"
sysconfdir = "/home/scat666/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "llvm_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "llvm_test_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "llvm_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "llvm_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "llvm_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
