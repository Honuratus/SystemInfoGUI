from PySide6.QtCore import QObject, QTimer, Signal, Slot, Property
import psutil

class RAMMonitor(QObject):

    # Signal for memory usage
    memUsageChanged = Signal(float, arguments=['usage'])

    # Constructor
    def __init__(self):
        super().__init__()
        self._used_memory = 0.0

        # Qt timer
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_mem_usage)
        self.interval = 5000

        # setting _total_memory
        total_mem = psutil.virtual_memory().total
        total_memory_gb = total_mem / (1024 ** 3)
        self.set_total_memory(total_memory_gb)

    # starting timer
    @Slot()
    def start_monitoring(self):
        self.timer.start(self.interval)

    # updating memory usage
    def update_mem_usage(self):
        used_memory_bytes = psutil.virtual_memory().used
        used_memory_gb = used_memory_bytes / (1024 ** 3)
        self._used_memory = used_memory_gb * 100 / self.get_total_memory()
        self.memUsageChanged.emit(round(self._used_memory, 2))

    # get and set methods for _total_memory
    def get_total_memory(self):
        return round(self._total_memory,2)

    def set_total_memory(self, val):
        self._total_memory = val


    # total memorty property for qml
    total_memory = Property(float, get_total_memory)
