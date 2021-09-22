module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { temp : Temperature }


type Temperature
    = Celsius Float
    | Fahrenheit Float


init : Model
init =
    { temp = Celsius 0 }


type Msg
    = Change (Maybe Temperature)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newTemp ->
            { model | temp = Maybe.withDefault model.temp newTemp }


view : Model -> Html Msg
view { temp } =
    let
        ( celsius, fahrenheit ) =
            temperatureInBothUnits temp
                |> Tuple.mapBoth String.fromFloat String.fromFloat
    in
    div []
        [ input [ type_ "number", onInput (String.toFloat >> Maybe.map Celsius >> Change), value celsius ] []
        , text " Celcius = "
        , input [ type_ "number", onInput (String.toFloat >> Maybe.map Fahrenheit >> Change), value fahrenheit ] []
        , text " Fahrenheit"
        ]


temperatureInBothUnits : Temperature -> ( Float, Float )
temperatureInBothUnits temp =
    case temp of
        Celsius c ->
            ( c, celciusToFahrenheit c )

        Fahrenheit f ->
            ( fahrenheitToCelsius f, f )


celciusToFahrenheit : Float -> Float
celciusToFahrenheit c =
    c * (9 / 5) + 32


fahrenheitToCelsius : Float -> Float
fahrenheitToCelsius f =
    (f - 32) * (5 / 9)
