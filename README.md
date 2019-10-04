# Open Robotics Darknet ROS

This is a ROS 2 wrapper around [darknet](https://pjreddie.com/darknet), an open source neural network framework.

![Example image with bounding boxes created using darknet and the yolov3-tiny network](doc/example_darknet_yolov3-tiny.png)

## DetectorNode

This node can run object detectors like [YOLOv3](https://pjreddie.com/darknet/yolo/) on images.

### Subscribers

* `~/images` (type `sensor_msgs/msg/Image`) - Input mages to feed to the detector

### Publishers

* `~/detections` (type `vision_msgs/msg/Detection2DArray`) - Objects detected in an image (if any)

### Parameters

* `network.config` - a path to a file describing a darknet detector network
* `network.weights` - a path to a file with weights for the given network
* `network.class_names` - a path to a file with names of classes the network can detect (1 per line)
* `detection.threshold` - Minimum probability of a detection to be published
* `detection.nms_threshold` - Non-maximal Suppression threshold - controls filtering of overlapping boxes
