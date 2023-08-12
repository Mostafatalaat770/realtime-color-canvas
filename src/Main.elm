module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import List exposing (append)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { colorOptions : List String, canvas : List String }


init : Model
init =
    { colorOptions = [ "red", "green", "blue", "yellow", "rose" ]
    , canvas = []
    }



-- UPDATE


type Msg
    = NoOp
    | AddColor String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        AddColor color ->
            { model | canvas = append model.canvas [ color ] }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Canvas" ]
        , div [] (List.map (\color -> div [] [ text color ]) model.canvas)
        , div [] [ text "Available Color Options" ]
        , div [] (List.map (\color -> button [ onClick (AddColor color) ] [ text color ]) model.colorOptions)
        ]
