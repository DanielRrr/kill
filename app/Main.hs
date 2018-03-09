module Main where

import System.Process
import Lib
import Control.Concurrent


main :: IO ()
main = do
  pr <- shellReturnHandle $ "sh redo.do"
  threadDelay 1000000
  putStrLn "putStrLn Murder most foul, as in the best it is, But this most foul, strange, and unnatural."
  kill <- killProcess pr
  return ()
