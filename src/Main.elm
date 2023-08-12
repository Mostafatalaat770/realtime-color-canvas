module Main exposing (main)
import Browser
import Html exposing (Html)
import Html exposing (div)
import Html exposing (text)

main = Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model = 
    {
    colorOptions : List String
    }


init: Model
init =
    { colorOptions = [ "red", "green", "blue", "yellow", "rose" ] }



-- UPDATE

type Msg
    = NoOp


update: Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW

view: Model -> Html Msg

view model =
    div []
        [ div [] [ text "Available Color Options" ]
        , div [] (List.map (\color -> div [] [ text color ]) model.colorOptions)
        ]

        