import os, sys
from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
# from plugins import GamePlugin

appname = "tic-tac-toe"
org = "rubbiesoft"

# plugin = GamePlugin("data\\intel.json")
os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"

# create application objects
app = QApplication(sys.argv)
app.setApplicationName(appname)
app.setOrganizationName(org)
app.setOrganizationDomain("org.%s.%s" %(org, appname.lower()))

# create qml app engine
engine = QQmlApplicationEngine()
# engine.rootContext().setContextProperty("Game", plugin)
engine.load("ui/app.qml")
engine.quit.connect(app.quit)
sys.exit(app.exec_())
