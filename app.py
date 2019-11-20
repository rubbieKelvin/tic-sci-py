import os, sys, joblib, json
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from plugins import GamePlugin, BotPlugin
from sklearn.linear_model import SGDClassifier

appname = "tic-tac-toe"
org = "rubbiesoft"
data_file = "data\\intel.json"
model_file = "data\\tic-sci-py.model"

if os.access(model_file, os.F_OK):
	model = joblib.load(model_file)
else:
	with open(data_file) as file:
		data = json.load(file)
	model = SGDClassifier()
	model.fit(data["data"], data["target"])

game_plugin = GamePlugin()
bot_plugin = BotPlugin(model, model_file, game_plugin)

# cut out the line below if the file is very large
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
