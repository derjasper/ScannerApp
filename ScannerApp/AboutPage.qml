import QtQuick 2.0
import Ubuntu.Components 1.3


Page {
    title: i18n.tr("About")
    head.sections.model: [i18n.tr("About"), i18n.tr("Licenses")]

    VisualItemModel {
        id: tabs

        Item {
            width: tabView.width
            height: tabView.height

            Flickable {
                clip: true
                anchors.fill: parent
                flickableDirection: Flickable.VerticalFlick

                contentWidth: width
                contentHeight: column1.height + units.gu(2)

                Column {
                    id: column1

                    spacing: units.gu(2)

                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        margins: units.gu(2)
                    }

                    UbuntuShape {
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: Image {
                            source: "ScannerApp.png"
                        }
                        width:100
                        height:100
                        radius:"medium"
                    }

                    Text {
                        text: "Scanner"
                        font.pointSize: 18
                        horizontalAlignment:Text.AlignHCenter
                        width:parent.width
                    }
                    Text {
                        text: i18n.tr("Document Scanner for Ubuntu Touch")
                        wrapMode:Text.WordWrap
                        horizontalAlignment:Text.AlignHCenter
                        width:parent.width
                    }

                    Text {
                        text: i18n.tr("For bug reports, pull requests and information on how to translate, please go to the GitHub project.")
                        wrapMode:Text.WordWrap
                        horizontalAlignment:Text.AlignHCenter
                        width:parent.width
                    }
                    Button {
                        text: i18n.tr("Scanner on GitHub")
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: UbuntuColors.orange
                        onClicked: {
                            Qt.openUrlExternally("https://github.com/derjasper/ScannerApp");
                        }
                    }

                    Text {
                        text: "(c) Jasper Nalbach\n" + i18n.tr("Licensed under GPLv3. Source code available at:") + "\n" + "https://github.com/derjasper/ScannerApp"
                        wrapMode:Text.WordWrap
                        horizontalAlignment:Text.AlignHCenter
                        width:parent.width
                    }
                }
            }
        }

        Item {
            width: tabView.width
            height: tabView.height

            Flickable {
                clip: true
                anchors.fill: parent
                flickableDirection: Flickable.VerticalFlick

                contentWidth: width
                contentHeight: column2.height + units.gu(2)

                Column {
                    id: column2

                    spacing: units.gu(2)

                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        margins: units.gu(2)
                    }

                    // TODO software licenses

                    // OpenCV
                    // QtOpenCV, (c) 2012-2015 Debao Zhang, https://github.com/dbzhang800/QtOpenCV
                    // QImageItem (Qt Extra Components), Copyright 2011 Marco Martin, GPLv2, ...
                    // mail?!??

                }
            }
        }
    }

    ListView {
        id: tabView
        model: tabs
        interactive: false
        anchors.fill: parent
        orientation: Qt.Horizontal
        snapMode: ListView.SnapOneItem
        currentIndex: aboutPage.head.sections.selectedIndex
        highlightMoveDuration: UbuntuAnimation.SlowDuration
    }
}
