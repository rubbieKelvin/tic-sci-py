import os, sys
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from plugins import GamePlugin, BotPlugin

appname = "tic-tac-toe"
org = "rubbiesoft"
bot_plugin = BotPlugin()
game_plugin = GamePlugin()


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
