extends GameScene

func start_game():
	Game.load_stage_1()

func go_to_credits():
	Game.load_credits()

func quit_game():
	Game.quit_game()
