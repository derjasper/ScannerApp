TEMPLATE = aux
TARGET = ScannerApp

RESOURCES += ScannerApp.qrc

QML_FILES += $$files(*.qml,true) \
             $$files(*.js,true)

CONF_FILES +=  ScannerApp.apparmor \
               ScannerApp.desktop \
               ScannerApp.png

OTHER_FILES += $${CONF_FILES} \
               $${QML_FILES} \
               content-hub.json

#specify where the qml/js files are installed to
qml_files.path = /ScannerApp
qml_files.files += $${QML_FILES}

#specify where the config files are installed to
config_files.path = /ScannerApp
config_files.files += $${CONF_FILES}

INSTALLS+=config_files qml_files

DISTFILES += \
    ScanPage.qml \
    ImportPage.qml \
    ResultPage.qml \
    MainPage.qml \
    Main.qml \
    AboutPage.qml \
    components/ActionIcon.qml

