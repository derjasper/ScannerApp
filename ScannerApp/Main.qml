import QtQuick 2.0
import Ubuntu.Components 1.3

MainView {
    objectName: "mainView"

    applicationName: "scannerapp.derjasper"

    automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)

    PageStack {
        id: pageStack
        Component.onCompleted: push(mainPage)

        MainPage {
            id: mainPage
        }

        ResultPage {
            id: resultPage
            visible: false
        }

        ScanPage {
            id: scanPage
            visible: false
        }

        AboutPage {
            id: aboutPage
            visible: false
        }
    }

    // TODO content handler

}

