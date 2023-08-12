module Frontend exposing (Model, app)

import Element exposing (..)
import Element.Background
import Element.Border
import Element.Input as Input
import Env exposing (..)
import Html exposing (Html)
import Lamdera
import List exposing (append)
import Types exposing (BackendMsg(..), FrontendModel, FrontendMsg(..), ToFrontend(..))


app =
    Lamdera.frontend
        { init = \_ _ -> init
        , update = update
        , updateFromBackend = updateFromBackend
        , view =
            \model ->
                { title = "Canvas"
                , body = [ view model ]
                }
        , subscriptions = \_ -> Sub.none
        , onUrlChange = \_ -> NoOpFrontendMsg
        , onUrlRequest = \_ -> NoOpFrontendMsg
        }



-- MODEL


type alias Model =
    FrontendModel


init : ( Model, Cmd FrontendMsg )
init =
    ( { colorOptions = [ red, green, blue, yellow, rose ]
      , canvas = []
      , clientId = ""
      }
    , Cmd.none
    )



-- UPDATE


update : FrontendMsg -> Model -> ( Model, Cmd FrontendMsg )
update msg model =
    case msg of
        NoOpFrontendMsg ->
            ( model, Cmd.none )

        AddColor color ->
            ( { model | canvas = append model.canvas [ color ] }, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        CanvasNewColors newColors clientId ->
            ( { model | canvas = newColors, clientId = clientId }, Cmd.none )

        NoOpToFrontend ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html FrontendMsg
view model =
    Element.layout
        []
    <|
        column
            [ spacing 10, padding 10 ]
            [ wrappedRow [ spacing 10 ]
                (List.map
                    (\color ->
                        el
                            [ width (px 50)
                            , height (px 50)
                            , Element.Border.rounded 50
                            , Element.Background.color color
                            ]
                            (text "")
                    )
                    model.canvas
                )
            , row
                [ spacing 10
                ]
                (List.map
                    (\color ->
                        Input.button
                            [ width (px 50)
                            , height (px 50)
                            , Element.Border.rounded 50
                            , Element.Background.color color
                            ]
                            { onPress = Just (AddColor color), label = text "" }
                    )
                    model.colorOptions
                )
            ]
