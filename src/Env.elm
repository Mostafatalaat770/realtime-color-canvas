module Env exposing (..)

import Types exposing (Color)



-- The Env.elm file is for per-environment configuration.
-- See https://dashboard.lamdera.app/docs/environment for more info.


dummyConfigItem =
    ""


color1 : Color
color1 =
    { red = 255, green = 0, blue = 0, alpha = 1 }


color2 : Color
color2 =
    { red = 0, green = 255, blue = 0, alpha = 1 }


color3 : Color
color3 =
    { red = 0, green = 0, blue = 255, alpha = 1 }


color4 : Color
color4 =
    { red = 255, green = 255, blue = 0, alpha = 1 }


color5 : Color
color5 =
    { red = 255, green = 0, blue = 255, alpha = 1 }
