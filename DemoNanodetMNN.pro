TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

LIBS += `pkg-config --libs opencv4`

INCLUDEPATH += /usr/local/include/MNN
LIBS += -L/usr/local/lib/ -lMNN -lMNN_Cuda_Main -lMNN_Express

SOURCES += main.cpp \
    nanodet.cpp

HEADERS += \
    nanodet.h
