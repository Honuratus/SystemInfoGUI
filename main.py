import sys
import os

from PySide6.QtGui import QGuiApplication, QSurfaceFormat
from PySide6.QtQml import QQmlApplicationEngine

from cpu_monitor import CPUMonitor
from gpu_monitor import GPUMonitor
from memory_monitor import RAMMonitor


if __name__ == "__main__":

    # for disabling the loggin of ridiculus qml warnings
    os.environ["QT_LOGGING_RULES"] = "*.debug=false;*.warning=false"

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Creating class instances
    cpu_monitor = CPUMonitor()
    gpu_monitor = GPUMonitor()
    mem_monitor = RAMMonitor()

    # Setting sample value
    format = QSurfaceFormat()
    format.setSamples(8)
    QSurfaceFormat.setDefaultFormat(format)


    engine.rootContext().setContextProperty("cpuMonitor", cpu_monitor)
    engine.rootContext().setContextProperty("gpuMonitor", gpu_monitor)
    engine.rootContext().setContextProperty("memMonitor", mem_monitor)

    # Loading qml file
    engine.load("components/main.qml")

    sys.exit(app.exec())
