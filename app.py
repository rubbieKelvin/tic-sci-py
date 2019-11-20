import os, sys
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from plugins import GamePlugin, BotPlugin

appname = "tic-tac-toe"
org = "rubbiesoft"
data_file = "data\\intel.json"


game_plugin = GamePlugin()
bot_plugin = BotPlugin(data_file, game_plugin)

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
