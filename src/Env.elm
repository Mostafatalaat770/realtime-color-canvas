module Env exposing (..)

import Element exposing (Color, Element)



-- The Env.elm file is for per-environment configuration.
-- See https://dashboard.lamdera.app/docs/environment for more info.


dummyConfigItem =
    ""


red : Color
red =
    Element.rgb 255 0 0


green : Color
green =
    Element.rgb 0 255 0


blue : Color
blue =
    Element.rgb 0 0 255


yellow : Color
yellow =
    Element.rgb 255 255 0


rose : Color
rose =
    Element.rgb 255 0 255
