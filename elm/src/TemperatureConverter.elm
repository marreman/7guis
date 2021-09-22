module TemperatureConverter exposing (main)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)



-- Temperature.elm


type Celsius
    = Celsius Float


type Fahrenheit
    = Fahrenheit Float


celsiusFromString : String -> Maybe Celsius
celsiusFromString =
    String.toFloat >> Maybe.map Celsius


celsiusToString : Celsius -> String
celsiusToString (Celsius c) =
    String.fromFloat c


fahrenheitToString : Fahrenheit -> String
fahrenheitToString (Fahrenheit f) =
    String.fromFloat f


fahrenheitFromString : String -> Maybe Fahrenheit
fahrenheitFromString =
    String.toFloat >> Maybe.map Fahrenheit


toCelsius : Fahrenheit -> Celsius
toCelsius (Fahrenheit f) =
    Celsius <| (f - 32) * (5 / 9)


toFahrenheit : Celsius -> Fahrenheit
toFahrenheit (Celsius c) =
    Fahrenheit <| c * (9 / 5) + 32



-- TemperatureConverter.elm


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    Maybe Celsius


init : Model
init =
    Nothing


type Msg
    = ChangeCelsiusIntent String
    | ChangeFahrenheitIntent String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeCelsiusIntent s ->
            celsiusFromString s

        ChangeFahrenheitIntent s ->
            fahrenheitFromString s |> Maybe.map toCelsius


view : Model -> Html Msg
view t =
    let
        c =
            Maybe.map celsiusToString t
                |> Maybe.withDefault ""

        f =
            Maybe.map (toFahrenheit >> fahrenheitToString) t
                |> Maybe.withDefault ""
    in
    Html.div []
        [ Html.input [ value c, onInput ChangeCelsiusIntent ] []
        , Html.input [ value f, onInput ChangeFahrenheitIntent ] []
        ]
