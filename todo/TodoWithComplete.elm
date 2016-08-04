module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import List


type alias Todo =
    { id : Int
    , task : String
    }


type alias Model =
    { todoList : List Todo
    , input : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model [] "", Cmd.none )


type Msg
    = AddTodo
    | OnInput String
    | CompleteTodo Todo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnInput val ->
            ( { model
                | input = val
              }
            , Cmd.none
            )

        AddTodo ->
            ( addTodo model, Cmd.none )

        CompleteTodo todo ->
            ( completeTodo todo model, Cmd.none )


addTodo : Model -> Model
addTodo model =
    let
        newTodo =
            Todo (List.length model.todoList) model.input

        newTodoList =
            newTodo :: model.todoList
    in
        { model
            | todoList = newTodoList
            , input = ""
        }


completeTodo : Todo -> Model -> Model
completeTodo todo model =
    let
        newTodoList =
            model.todoList
                |> List.filter
                    (\todo' -> todo'.id /= todo.id)
    in
        { model
            | todoList = newTodoList
        }


view : Model -> Html Msg
view model =
    div []
        [ todoInput model
        , todoList model
        ]


todoInput : Model -> Html Msg
todoInput model =
    div []
        [ input
            [ type' "text"
            , placeholder "Add todo"
            , value model.input
            , onInput OnInput
            ]
            []
        , button
            [ type' "button"
            , onClick AddTodo
            ]
            [ text "Add" ]
        ]


todoList : Model -> Html Msg
todoList model =
    model.todoList
        |> List.map (\todo -> todoItem todo)
        |> div []


todoItem : Todo -> Html Msg
todoItem todo =
    div []
        [ span []
            [ text todo.task ]
        , button
            [ type' "button"
            , onClick (CompleteTodo todo)
            ]
            [ text "complete" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
