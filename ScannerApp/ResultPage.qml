import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.3
import ScannerApp 1.0
import Qt.labs.settings 1.0
import "components"


Page {
    id: page

    title: i18n.tr("Result")

    head.actions: [
        Action {
            iconName: "save"
            text: i18n.tr("Save")
            visible: isTransformed
            onTriggered: {
                scanner.saveImage(""); // TODO temp file?
            }
        }
    ]

    property bool isTransformed: false;

    function processImage(url) {
        isTransformed = false;
        scanner.image = url;
    }

    function mod(n, m) {
        return ((n % m) + m) % m;
    }

    Settings {
        id: settings

        property int filter: 1
    }

    Scanner {
        id: scanner
        mode: settings.filter
        rotation: 0
        onProcessed: {
            imageViewer.image = image
            isTransformed = true
        }
        onImageChanged: {
            rotation = 0
        }

        onImageSaved: {
            // TODO onSaved: export to content hub
        }
    }

    Rectangle {
        anchors.fill: parent
        color: theme.palette.normal.backgroundText
        visible: isTransformed
    }

    ImageItem {
        id: imageViewer
        anchors.fill: parent
        fillMode: ImageItem.PreserveAspectFit
        visible: isTransformed
    }

    ActivityIndicator {
        anchors.centerIn: parent
        running: scanner.busy
    }

    Row {
        visible: isTransformed

        anchors {
            bottom: parent.bottom
            bottomMargin: units.gu(1)
            horizontalCenter: parent.horizontalCenter
        }

        ActionIcon {
            icon.name: "rotate-left"
            icon.width: units.gu(4)
            onClicked: {
                scanner.rotation = mod(scanner.rotation - 1, 4);
            }
        }

        ActionIcon {
            icon.name: "rotate-right"
            icon.width: units.gu(4)
            onClicked: {
                scanner.rotation = mod(scanner.rotation + 1, 4);
            }
        }

        ActionIcon {
            id: filterButton
            icon.name: "filters"
            icon.width: units.gu(4)
            onClicked: PopupUtils.open(filterComponent, filterButton)
        }
    }

    Component {
        id: filterComponent
        Popover {
            id: filter
            Column {
                anchors {
                    left: parent.left
                    top: parent.top
                    right: parent.right
                }
                ListItem.Standard {
                    text: i18n.tr("no filter")
                    onClicked: {
                        settings.filter = 0;
                        PopupUtils.close(filter);
                    }
                }
                ListItem.Standard {
                    text: i18n.tr("text only")
                    onClicked: {
                        settings.filter = 1;
                        PopupUtils.close(filter);
                    }
                }
                ListItem.Standard {
                    text: i18n.tr("photo and text")
                    onClicked: {
                        settings.filter = 2;
                        PopupUtils.close(filter);
                    }
                }
                ListItem.Standard {
                    text: i18n.tr("photo only")
                    onClicked: {
                        settings.filter = 3;
                        PopupUtils.close(filter);
                    }
                }
            }
        }
    }
}

