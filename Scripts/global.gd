extends Node

							###################################
							##### GLOBAL PLAYER VARIABLES #####
							###################################

# Variables for player holding things
var player_holdingItem = false
var player_itemName = "NULL"
var PLAYER_IN_BATTLE = 0

# Variables for player health and fatigue
var player_health = 100
var player_fatigue = 0
var player_speed  = 30

# Variables for player location
var player_location = "Bedroom1"
var player_x
var player_y


							#####################################
							##### MINIGAME STORED VARIABLES #####
							#####################################

# Variables for washing machine miningame
var washingMachine_minigameStarted = false
var clothes_loaded = false
var washingMachine_time = 120


						########################################
						#### BABY STORED LOCATION VARIABLES ####
						########################################
var baby_location = "Bedroom1"
var baby_position_x = -183.324997
var baby_position_y = 27.4405

						########################################
						#### GLOBAL BABY VARIABLES #############
						########################################
var baby_health = 100
var baby_speed = 8