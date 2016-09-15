import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1

Page {
    id: mainPage
    title: i18n.tr("Scanner")

    head.actions: [
        Action {
            iconName: "import"
            text: i18n.tr("Import")
            onTriggered: {
                importFromContentHub()
                /*
                pageStack.push(resultPage);
                resultPage.processImage(Qt.resolvedUrl("/home/jasper/Dokumente/Projekte/UbuntuApps/ScannerApp/ScannerApp/data/img5.jpg"));
                */
            }
        },
        Action {
            iconName: "info"
            text: i18n.tr("About")
            onTriggered: {
                pageStack.push(aboutPage);
            }
        }
    ]

    Text {
        anchors.centerIn: parent
        width:parent.width
        horizontalAlignment: Text.AlignHCenter
        text: i18n.tr("Click here to start scanning")
        wrapMode: Text.WordWrap
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            pageStack.push(scanPage);
        }
    }

    // Content Hub // TODO import from ContentHub
    property var activeTransfer
    ContentPeer {
      id: picSourceSingle
      contentType: ContentType.Pictures
      handler: ContentHandler.Source
      selectionType: ContentTransfer.Single
    }
    function importFromContentHub() {
        mainPage.activeTransfer = picSourceSingle.request()
    }
    ContentTransferHint {
      id: transferHint
      anchors.fill: parent
      activeTransfer: mainPage.activeTransfer
    }
    Connections {
      target: mainPage.activeTransfer
      onStateChanged: {
          if (mainPage.activeTransfer.state === ContentTransfer.Charged) {
              pageStack.push(resultPage);
              resultPage.processImage(mainPage.activeTransfer.items[0].url);
          }
      }
    }

}
