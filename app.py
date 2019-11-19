import os, sys, pickle
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from plugins import GamePlugin, BotPlugin
from sklearn.linear_model import SGDClassifier

appname = "tic-tac-toe"
org = "rubbiesoft"
model_file = "data\\tic-sci-py.model"

# create ml model
if os.access(model_file, os.F_OK):
	print(f"reading model from file... {model_file}")
	model = pickle.load(open(model_file, 'rb'))
else:
	# create from beginning
	print("creating model")
	X = [[1, 4, 5, 3, 9, 0, 0, 0, 0], [2, 5, 1, 9, 8, 3, 6, 4, 0], [3, 5, 2, 1, 6, 9, 0, 0, 0]]
	y = [-1, 0, 1]
	model = SGDClassifier()
	model.fit(X, y)


game_plugin = GamePlugin()
bot_plugin = BotPlugin(model, game_plugin)
bot_plugin.filename = model_file
game_plugin.bot = bot_plugin

os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"

# create application objects
app = QApplication(sys.argv)
app.setApplicationName(appname)
app.setOrganizationName(org)
app.setOrganizationDomain("org.%s.%s" %(org, appname.lower()))

# create qml app engine
engine = QQmlApplicationEngine()

# register plugins
engine.rootContext().setContextProperty("Game", game_plugin)
engine.rootContext().setContextProperty("Bot", bot_plugin)

# load ui
engine.load("ui/app.qml")
engine.quit.connect(app.quit)

# exit with execution code
sys.exit(app.exec_())
