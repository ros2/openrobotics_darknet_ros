cmake_minimum_required(VERSION 3.10)
project(openrobotics_darknet_ros)

option(DOWNLOAD_YOLO_CONFIG "Download YOLO configuration files" OFF)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(NOT WIN32)
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(cv_bridge REQUIRED)
find_library(Darknet darknet REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(vision_msgs REQUIRED)

add_library(openrobotics_darknet_ros SHARED
  src/detector_network.cpp
  src/parse.cpp)
target_include_directories(openrobotics_darknet_ros PUBLIC include)
target_compile_definitions(openrobotics_darknet_ros PRIVATE "DARKNET_ROS_BUILDING_DLL")
ament_target_dependencies(openrobotics_darknet_ros
  cv_bridge
  sensor_msgs
  vision_msgs)
target_link_libraries(openrobotics_darknet_ros "${Darknet}")
# Necessary as Darknet currently does not install to ./install/darknet/libdarknet.so
set_target_properties(openrobotics_darknet_ros PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

add_library(detector_node SHARED
  src/detector_node.cpp)
target_compile_definitions(detector_node PRIVATE "DARKNET_ROS_NODE_BUILDING_DLL")
ament_target_dependencies(detector_node PUBLIC
  "rclcpp"
  "rclcpp_components")
target_link_libraries(detector_node PUBLIC openrobotics_darknet_ros)
rclcpp_components_register_nodes(detector_node "openrobotics::darknet_ros::DetectorNode")

add_executable(detector_node_main
  src/detector_node_main.cpp)
target_link_libraries(detector_node_main detector_node)
set_target_properties(detector_node_main PROPERTIES OUTPUT_NAME "detector_node")

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  ament_add_gtest(test_parser test/test_parser.cpp
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test/")
  target_link_libraries(test_parser openrobotics_darknet_ros)

  ament_add_gtest(test_detector_network test/test_detector_network.cpp)
  target_link_libraries(test_detector_network openrobotics_darknet_ros)
endif()

ament_export_libraries(openrobotics_darknet_ros)

install(TARGETS openrobotics_darknet_ros
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

install(TARGETS detector_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

install(TARGETS detector_node_main
  DESTINATION lib/${PROJECT_NAME})

# Download weights for Yolo v3, v4 and v7
if (DOWNLOAD_YOLO_CONFIG)
  include(ConfigDownload.cmake)
endif()

install(DIRECTORY config/ launch/ DESTINATION share/${PROJECT_NAME})
install(DIRECTORY config/ DESTINATION share/${PROJECT_NAME}/config)
install(DIRECTORY include/ DESTINATION include)

ament_package()
