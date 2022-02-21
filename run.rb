require 'ruby2d'

set title: "Reaction"

game_started = false
square = nil
start_time = nil
duration = nil
@squares_left = 10
@end_message = nil
game_over = false

welcome_message = Text.new(
    'Click to start',
    x: 0, y: 0,
    style: 'bold',
    size: 20,
    color: 'blue',
    z: 10
)

squares_left_text = Text.new(
    "Squares: #{@squares_left}",
    x: 0, y: 0,
    style: 'bold',
    size: 15,
    color: 'blue',
    z: 10
)

square = Square.new(
    x: 100, y: 200,
    size: 125,
    color: 'blue'
)

welcome_message.x = ((Window.width - welcome_message.width) / 2)
welcome_message.y = ((Window.height - welcome_message.height) / 2)

squares_left_text.x = ((Window.width - 5) - squares_left_text.width) 

def move_square(square, squares_left)
    square.x = rand(0..(Window.width - square.width))
    square.y = rand(0..(Window.height - square.width))
    @squares_left -= 1
end

def display_results(duration)
    @end_message = Text.new(
        "You clicked on 10 squares in #{duration} seconds",
        x: 0, y: 0,
        style: 'bold',
        size: 20,
        color: 'blue',
        z: 10
    )
    @end_message.x = ((Window.width - @end_message.width) / 2)
    @end_message.y = ((Window.height - @end_message.height) / 2)
end

on :mouse_up do |event|

    case event.button

        when :left
        if game_started
            if @squares_left <= 0
                game_over = true
                square.remove
                display_results(duration)
                start_time = nil
                duration = nil
                @squares_left = 10
            elsif game_over
                @end_message.remove
                welcome_message.add
                game_over = false
                game_started = false
            else
                if square.contains?(event.x, event.y)
                    move_square(square, @squares_left)
                    duration = Time.now - start_time
                end
            end
        else
            welcome_message.remove
            game_started = true
            square.add
            start_time = Time.now
        end
    end
end

update do
    squares_left_text.text = "Squares: #{@squares_left}"
end

square.remove

show