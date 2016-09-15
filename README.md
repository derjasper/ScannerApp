# ScannerApp for Ubuntu Touch

Office Lens like document scanning.

This project lays way to long on my hard drive. I sporadically code on this project since I do not own an Ubuntu Phone yet and have other projects. Feel free to take over development.

## Planned features

* scan an image using the camera (with live preview of detected edges)
* different filters, image rotation
* export/import from content hub

## What's done

* a small C++ lib that does the processing using open-cv (see https://github.com/derjasper/Scanner)
* taking a photo and process it
* image rotation and filter selection
* simple UI
* started implementation of edge preview using QVideoFilter

## To be done

* get it to work with the new container-based Ubuntu SDK (and link open-cv statically or include it in the click package)
** Qt 5.5 is needed for QVideoFilter, which is not available in the container, so you may set up a desktop kit for development
* content hub integration
* live preview of edges
** convert a QVideoFrame to a cv::Mat
** run edge detection in own thread

## Contact

If you have any questions, feel free to contact me.

## License

GPLv3.
