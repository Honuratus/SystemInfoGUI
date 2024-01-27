from PySide6.QtCore import QObject, Qt, QTimer, Signal, Slot, Property
import psutil
from cpuinfo import get_cpu_info

class CPUMonitor(QObject):

    # Cpu usage signal
    cpuUsageChanged = Signal(float,arguments=['usage'])

    # Constructor
    def __init__(self, parent=None):
        super().__init__(parent)
        self._cpu_usage = 0.0
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_cpu_usage)
        self.interval = 1000

        self.set_cpu_freq(psutil.cpu_freq().current)
        self.set_cpu_brand(get_cpu_info()['brand_raw'])
        self.set_cpu_core(psutil.cpu_count(logical=False))

    # Starting qt timer
    @Slot()
    def start_monitoring(self):
        self.timer.start(self.interval)

    # Updating cpu usage
    @Slot()
    def update_cpu_usage(self):
        cpu_percent = psutil.cpu_percent(interval=None)
        self._cpu_usage = cpu_percent
        self.cpuUsageChanged.emit(cpu_percent)

    # Get and Set for brand name
    def get_cpu_brand(self):
        return self._cpu_brand

    def set_cpu_brand(self, brand):
        self._cpu_brand = brand


    # Get and Set for freq
    def get_cpu_freq(self):
        return self._cpu_freq

    def set_cpu_freq(self, freq):
        self._cpu_freq = freq

    # Get and Set for cpu core
    def get_cpu_core(self):
        return self._cpu_core

    def set_cpu_core(self, core):
        self._cpu_core = core

    # Properties for accesing on qml side
    cpu_brand = Property(str, get_cpu_brand)
    cpu_freq = Property(float, get_cpu_freq)
    cpu_core = Property(int, get_cpu_core)



