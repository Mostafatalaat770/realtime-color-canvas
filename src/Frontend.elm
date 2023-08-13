module Frontend exposing (Model, app)

import Browser.Dom
import Element exposing (..)
import Element.Background
import Element.Border
import Element.Input as Input
import Env exposing (..)
import Html exposing (Html)
import Html.Attributes
import Lamdera exposing (sendToBackend)
import List exposing (append)
import Platform exposing (Task)
import Task exposing (Task)
import Types exposing (BackendMsg(..), FrontendModel, FrontendMsg(..), ToBackend(..), ToFrontend(..))


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
            ( { model | canvas = append model.canvas [ color ] }, Cmd.batch [ sendToBackend (ColorAdded color), scrollToBottom ] )

        ResetCanvas ->
            ( { model | canvas = [] }, sendToBackend CanvasHasBeenReset )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg )
updateFromBackend msg model =
    case msg of
        CanvasNewColors newColors clientId ->
            ( { model | canvas = newColors, clientId = clientId }, scrollToBottom )

        NoOpToFrontend ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html FrontendMsg
view model =
    Element.layout
        []
    <|
        column
            [ spacing 10, padding 10, height fill, width fill ]
            [ el [ height (fillPortion 4), scrollbarY, htmlAttribute (Html.Attributes.id "canvas-container"), width (fill |> maximum 568), centerX, htmlAttribute (Html.Attributes.style "overflow-x" "hidden") ]
                (wrappedRow [ spacing 10 ]
                    (List.map
                        (\color ->
                            colorElement color False
                        )
                        model.canvas
                    )
                )
            , row
                [ spacing 10, height (fillPortion 1), centerX ]
                [ row [ spacing 10 ]
                    (List.map
                        (\color ->
                            colorElement color True
                        )
                        model.colorOptions
                    )
                , Input.button
                    []
                    { onPress = Just ResetCanvas, label = text "Reset" }
                ]
            ]


colorElement : Types.Color -> Bool -> Element FrontendMsg
colorElement color isButton =
    if isButton then
        Input.button
            [ width (px 50)
            , height (px 50)
            , Element.Border.rounded 50
            , Element.Background.color (fromRgb color)
            ]
            { onPress = Just (AddColor color), label = text "" }

    else
        el
            [ width (px 50)
            , height (px 50)
            , Element.Border.rounded 50
            , Element.Background.color (fromRgb color)
            ]
            (text "")


scrollToBottom : Cmd FrontendMsg
scrollToBottom =
    Browser.Dom.getViewportOf "canvas-container"
        |> Task.andThen
            (\viewport ->
                Browser.Dom.setViewportOf "canvas-container" 0 viewport.scene.height
            )
        |> Task.attempt (\_ -> NoOpFrontendMsg)
