{-# OPTIONS_GHC -cpp #-}

module Lib
        ( stopProcess,
          killProcess
        ) where

import Control.Concurrent.MVar (readMVar)

#ifdef mingw32_HOST_OS
import System.Win32.Console (generateConsoleCtrlEvent, cTRL_C_EVENT)
import System.Win32.Process (getProcessId, terminateProcessById)
import qualified System.Process as P
import qualified System.Process.Internals as Pi
#else
import System.Posix.Signals hiding (killProcess)
import System.Process (terminateProcess)
import System.Process.Internals (ProcessHandle__(..),
                                 ProcessHandle(..),
                                 withProcessHandle)
#endif

#ifdef mingw32_HOST_OS
stopProcess :: P.ProcessHandle -> IO ()
stopProcess ph = do
  pid <- P.getPid ph
  stop <- case pid of
    Nothing -> print "wtf"
    Just pD -> generateConsoleCtrlEvent cTRL_C_EVENT pD

killProcess :: P.ProcessHandle -> IO ()
killProcess ph = do
  pid <- P.getPid ph
  case pid of
    Nothing -> putStrLn "wtf"
    Just pD -> terminateProcessById pD

#else
stopProcess :: ProcessHandle -> IO ()
stopProcess = terminateProcess

killProcess :: ProcessHandle -> IO ()
killProcess ph = do
  withProcessHandle ph $ \p_ ->
    case p_ of
      ClosedHandle _ -> return ()
      OpenHandle h -> do
        signalProcess sigKILL h
#endif
