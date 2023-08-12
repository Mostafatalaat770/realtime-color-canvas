module Env exposing (..)

import Types exposing (Color)



-- The Env.elm file is for per-environment configuration.
-- See https://dashboard.lamdera.app/docs/environment for more info.


dummyConfigItem =
    ""


red : Color
red =
    { red = 255, green = 0, blue = 0, alpha = 1 }


green : Color
green =
    { red = 0, green = 255, blue = 0, alpha = 1 }


blue : Color
blue =
    { red = 0, green = 0, blue = 255, alpha = 1 }


yellow : Color
yellow =
    { red = 255, green = 255, blue = 0, alpha = 1 }


rose : Color
rose =
    { red = 255, green = 0, blue = 255, alpha = 1 }
