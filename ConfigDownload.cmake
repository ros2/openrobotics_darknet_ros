# Download weights for Yolo v3, v4 and v7

# Yolo v3
# See https://pjreddie.com/darknet/yolo/
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfgyolov3.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3/yolov3.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  hhttps://github.com/hank-ai/darknet/releases/download/v2.0/yolov3.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3/yolov3.weights
  SHOW_PROGRESS
)
# Yolo v3 tiny
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3-tiny/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfgyolov3-tiny.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3-tiny/yolov3-tiny.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://github.com/hank-ai/darknet/releases/download/v2.0/yolov3-tiny.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v3-tiny/yolov3-tiny.weights
  SHOW_PROGRESS
)

# Yolo v4
# See https://github.com/AlexeyAB/darknet#pre-trained-models
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfgyolov4.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4/yolov4.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://github.com/hank-ai/darknet/releases/download/v2.0/yolov4.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4/yolov4.weights
  SHOW_PROGRESS
)

# Yolo v4 tiny
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4-tiny/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfgyolov4-tiny.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4-tiny/yolov4-tiny.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://github.com/hank-ai/darknet/releases/download/v2.0/yolov4-tiny.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v4-tiny/yolov4-tiny.weights
  SHOW_PROGRESS
)

# Yolo v7
# See https://github.com/AlexeyAB/darknet/issues/8595
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfgyolov7.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7/yolov7.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://github.com/hank-ai/darknet/releases/download/v2.0/yolov7.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7/yolov7.weights
  SHOW_PROGRESS
)
# Yolo v7 tiny
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/coco.names
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7-tiny/coco.names
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://raw.githubusercontent.com/hank-ai/darknet/master/cfg/yolov7-tiny.cfg
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7-tiny/yolov7-tiny.cfg
  SHOW_PROGRESS
)
file(DOWNLOAD
  https://github.com/hank-ai/darknet/releases/download/v2.0/yolov7-tiny.weights
  ${CMAKE_CURRENT_BINARY_DIR}/config/yolo-v7-tiny/yolov7-tiny.weights
  SHOW_PROGRESS
)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/config/ DESTINATION share/${PROJECT_NAME}/config/)
