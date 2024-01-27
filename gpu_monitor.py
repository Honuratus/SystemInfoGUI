from PySide6.QtCore import QObject, QTimer, Signal, Slot, Property
import psutil
import GPUtil

class GPUMonitor(QObject):

    # Signals
    gpuUsageChanged = Signal(float, arguments=['usage'])
    gpuTempChanged = Signal(float, arguments=['temp'])

    # Constructor
    def __init__(self):
        super().__init__()
        self._gpu_usage = 0.0
        self._temp = 0.0

        # Qt timer
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_gpu_info)
        self.interval = 5000

        self.set_gpu_brand(GPUtil.getGPUs()[0].name)
        self.set_gpu_vram(GPUtil.getGPUs()[0].memoryTotal)

    # Starting Qt timer
    @Slot()
    def start_monitoring(self):
        self.timer.start(self.interval)

    # Updating gpu usage
    def update_gpu_usage(self):
        gpu = GPUtil.getGPUs()[0]
        self._gpu_usage = gpu.load * 100
        self.gpuUsageChanged.emit(gpu.load * 100)

    # Updating gpu temp
    def update_gpu_temp(self):
        gpu = GPUtil.getGPUs()[0]
        self._temp = gpu.temperature
        self.gpuTempChanged.emit(self._temp)

    # Update all info
    @Slot()
    def update_gpu_info(self):
        self.update_gpu_temp()
        self.update_gpu_usage()

    # get and set for gpu_brand
    def get_gpu_brand(self):
        return self._gpu_brand
    def set_gpu_brand(self, brand):
        self._gpu_brand = brand


    #get and set for gpu_temp vram
    def get_gpu_vram(self):
        return self._vram
    def set_gpu_vram(self,vram):
        self._vram = vram

    # Properties for qml
    gpu_brand = Property(str, get_gpu_brand)
    gpu_vram = Property(float, get_gpu_vram)


