cmake_minimum_required(VERSION 3.10)
project(openrobotics_darknet_ros)

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(NOT WIN32)
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(cv_bridge REQUIRED)
find_package(darknet_vendor REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_components REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(vision_msgs REQUIRED)

add_library(openrobotics_darknet_ros SHARED
  src/network.cpp
  src/parse.cpp)
target_include_directories(openrobotics_darknet_ros PUBLIC include)
target_compile_definitions(openrobotics_darknet_ros PRIVATE "OPENROBOTICS_DARKNET_ROS_BUILDING_DLL")
ament_target_dependencies(openrobotics_darknet_ros
  cv_bridge
  darknet_vendor
  sensor_msgs
  vision_msgs)

add_library(darknet_node SHARED
  src/darknet_node.cpp)
target_compile_definitions(darknet_node PRIVATE "DARKNET_NODE_BUILDING_DLL")
ament_target_dependencies(darknet_node PUBLIC
  "rclcpp"
  "rclcpp_components")
target_link_libraries(darknet_node PUBLIC openrobotics_darknet_ros)
rclcpp_components_register_nodes(darknet_node "openrobotics::darknet_ros::DarknetNode")

add_executable(darknet_node_main
  src/darknet_node_main.cpp)
target_link_libraries(darknet_node_main darknet_node)
set_target_properties(darknet_node_main PROPERTIES OUTPUT_NAME "darknet_node")

if(BUILD_TESTING)
  find_package(ament_cmake_gtest REQUIRED)
  ament_add_gtest(test_parser test/test_parser.cpp
    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/test/")
  target_link_libraries(test_parser openrobotics_darknet_ros)

  ament_add_gtest(test_network test/test_network.cpp)
  target_link_libraries(test_network openrobotics_darknet_ros)
endif()

ament_export_libraries(openrobotics_darknet_ros)

install(TARGETS openrobotics_darknet_ros
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

install(TARGETS darknet_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)

install(TARGETS darknet_node_main
  DESTINATION lib/${PROJECT_NAME})

install(DIRECTORY include/ DESTINATION include)

ament_package()
