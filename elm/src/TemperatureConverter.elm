module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, pre, text)
import Html.Attributes exposing (attribute, type_, value)
import Html.Events exposing (onInput)
import Maybe.Extra


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { c : String, f : String }


init : Model
init =
    Model "" ""



-- UPDATE


type Msg
    = UpdateCelsius String
    | UpdateFahrenheit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateCelsius c ->
            { c = c, f = convert c toFahrenheit model.f }

        UpdateFahrenheit f ->
            { c = convert f toCelsius model.c, f = f }


convert : String -> (Float -> Float) -> String -> String
convert x fn default =
    String.toFloat x
        |> Maybe.map (fn >> String.fromFloat)
        |> Maybe.withDefault default


toCelsius : Float -> Float
toCelsius f =
    (f - 32) * (5 / 9)


toFahrenheit : Float -> Float
toFahrenheit c =
    c * (9 / 5) + 32



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ value model.c, onInput UpdateCelsius ] []
        , text " Celsius = "
        , input [ value model.f, onInput UpdateFahrenheit ] []
        , text " Fahrenheit"
        , pre [] [ model |> Debug.toString |> text ]
        ]
