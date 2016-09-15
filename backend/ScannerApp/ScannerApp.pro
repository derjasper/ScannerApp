TEMPLATE = lib
TARGET = ScannerAppbackend
QT += qml quick multimedia
CONFIG += qt plugin

load(ubuntu-click)

TARGET = $$qtLibraryTarget($$TARGET)

# Input
SOURCES += \
    backend.cpp \
    scanner.cpp \
    qmlscanner.cpp \
    cvmatandqimage.cpp \
    processingtask.cpp \
    qimageitem.cpp \
    scannerfilter.cpp

HEADERS += \
    backend.h \
    qmlscanner.h \
    scanner.h \
    scannerfilter.h \
    cvmatandqimage.h \
    processingtask.h \
    qimageitem.h

OTHER_FILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
installPath = $${UBUNTU_CLICK_PLUGIN_PATH}/ScannerApp
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir



unix: CONFIG += link_pkgconfig
unix: PKGCONFIG += opencv
