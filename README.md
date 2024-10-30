# Open Robotics Darknet ROS

This is a **ROS 2 wrapper around [darknet](https://github.com/hank-ai/darknet)**, an open source neural network framework.

![Example image with bounding boxes created using darknet and the yolov3-tiny network](doc/example_darknet_yolov3-tiny.png)

## DetectorNode

This node can run **object detectors** like [YOLO v3](https://pjreddie.com/darknet/yolo/) or [YOLO v7](https://github.com/WongKinYiu/yolov7) on images and video streams.

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

## Dependencies

This package depends on [darknet](https://github.com/AlexeyAB/darknet). If you can't use CUDA but want to use your CPU instead make sure to build it with the flag `-DENABLE_CUDA=OFF` and potentially also disabling multi-threading with `-DCMAKE_DISABLE_FIND_PACKAGE_OpenMP=TRUE`.

### Launching

Compiling this package with

```bash
$ colcon build --cmake-args -DDOWNLOAD_YOLO_CONFIG=ON
```

will automatically download the pretrained YOLO v3, v4 and v7 configuration files.

You can then launch the detector node with

```bash
$ ros2 launch openrobotics_darknet_ros detector_launch.py rgb_image:=/topic
```

optionally supplying a desired parameter file `detector_parameters:=path/to/detector_node_params.yaml`.

You can also train YOLO to detect custom objects like described [here](https://github.com/AlexeyAB/darknet#how-to-train-tiny-yolo-to-detect-your-custom-objects) and create the following as `detector_node_params.yaml`:

```yaml
/**:
  ros__parameters:
    network:
      config: "./your-yolo-config.cfg"
      weights: "./your-yolo-weights.weights"
      class_names: "./your-cocos.names"
    detection:
      threshold: 0.25
      nms_threshold: 0.45
```

Finally you can run the detector node with

```bash
$ ros2 run openrobotics_darknet_ros detector_node --ros-args --params-file path/to/detector_node_params.yaml
```

and publish images on `~/images` to get the node to detect objects. You can also manually remap an external topic to the `~/images` topic with:

```bash
$ ros2 run openrobotics_darknet_ros detector_node --ros-args --params-file path/to/detector_node_params.yaml -r '~/images:=/your/camera/topic'
```

