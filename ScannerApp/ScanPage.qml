import QtQuick 2.0
import Ubuntu.Components 1.3
import QtMultimedia 5.4
import ScannerApp 1.0
import "components"

Page {
    id: page

    title: i18n.tr("Scanner")

    onVisibleChanged: {
        if (visible) {
            camera.start();
        } else {
            camera.stop();
        }
    }

    Timer {
        id: captureTimer
        interval: 500
        repeat: true
        running: page.active

        onTriggered: {
            console.log("timer")
            filter.updateEdges()
        }


    }

    Camera {
        id: camera

        imageCapture {
            onImageSaved: {
                pageStack.push(resultPage);
                resultPage.processImage(path);
            }
        }
    }

    ScannerFilter {
        id: filter
        onFinished: {
            console.log("got edges", JSON.stringify(result))

            var context = canvas.getContext("2d");
            context.reset();

            context.strokeStyle = "#00FF00";
            context.lineWidth = 10;


            if (result.size === 4) {
                context.moveTo(result[0].x,result[0].y);
                context.lineTo(result[1].x,result[1].y);
                context.lineTo(result[2].x,result[2].y);
                context.lineTo(result[3].x,result[3].y);
                context.lineTo(result[0].x,result[0].y);
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: theme.palette.normal.backgroundText
    }

    VideoOutput {
        source: camera
        filters: [ filter ]
        anchors.fill: parent
    }

    Canvas {
        id: canvas
        anchors.fill: parent
    }

    Row {
        anchors {
            bottom: parent.bottom
            bottomMargin: units.gu(1)
            horizontalCenter: parent.horizontalCenter
        }

        ActionIcon {
            icon.name: "media-record"
            icon.width: units.gu(4)
            onClicked: {
                camera.imageCapture.capture()
            }
        }
    }

    // TODO flash
}

