module Evergreen.V1.Types exposing (..)

import Lamdera


type alias Color =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


type alias FrontendModel =
    { colorOptions : List Color
    , canvas : List Color
    , clientId : String
    }


type alias BackendModel =
    { colorOptions : List Color
    , canvas : List Color
    }


type FrontendMsg
    = NoOpFrontendMsg
    | AddColor Color
    | ResetCanvas


type ToBackend
    = NoOpToBackend
    | ColorAdded Color
    | CanvasHasBeenReset


type BackendMsg
    = ClientConnected Lamdera.SessionId Lamdera.ClientId
    | NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
    | CanvasNewColors (List Color) String
