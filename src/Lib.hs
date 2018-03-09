{-# OPTIONS_GHC -cpp #-}

module Lib
        ( stopProcess,
          killProcess,
          shellReturnHandle
        ) where

import System.Process
import System.Process.Internals ( withProcessHandle
                                , ProcessHandle__(..)
                                , ProcessHandle )

#if defined(OS_WINDOWS)
import System.Win32.Console (generateConsoleCtrlEvent, cTRL_C_EVENT)
#else
import System.Posix.Signals hiding (killProcess)
#endif

#if defined(WINDOWS)

stopProcess :: ProcessHandle -> IO ()
stopProcess ph = do
  pid <- getPid ph
  stop <- case pid of
    Nothing -> print "wtf"
    Just pD -> generateConsoleCtrlEvent cTRL_C_EVENT pD
  putStrLn "stop"
  return ()

killProcess :: ProcessHandle -> IO ()
killProcess ph = terminateProcess ph


#else

stopProcess :: ProcessHandle -> IO ()
stopProcess ph = terminateProcess ph

killProcess :: ProcessHandle -> IO ()
killProcess ph = do
  withProcessHandle ph $ \p_ ->
    case p_ of
      ClosedHandle _ -> return ()
      OpenHandle h -> do
        signalProcess sigKILL h
        putStrLn "Murder most foul, as in the best it is, But this most foul, strange, and unnatural."
        return ()

#endif

shellReturnHandle :: String -> IO ProcessHandle
shellReturnHandle cmd = do
  (_, _, _, phandle) <- createProcess (shell cmd)
  return phandle
