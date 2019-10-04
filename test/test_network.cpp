// Copyright 2019 Open Source Robotics Foundation, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <openrobotics_darknet_ros/network.hpp>

TEST(network, simple_detection)
{
  // TODO(sloretz) load config
  std::string config;
  // TODO(sloretz) load weights
  std::string weights;
  // TODO(sloretz) load classes
  std::vector<std::string> classes{"foo", "bar"};

  openrobotics_darknet_ros::Network network(config, weights, classes);

  // TODO(sloretz) create image
  sensor_msgs::msg::Image input_image;
  double threshold = 0.5;
  vision_msgs::msg::Detection2DArray detections;
  const size_t num_detections = network.detect(input_image, threshold, &detections);

  ASSERT_EQ(1, num_detections);
  ASSERT_EQ(detections.header, input_image.header);
  ASSERT_LE(0.5, detections.results.at(0).score);
  // TODO(slorez) bouding box
  // TODO(sloretz) source_img empty
}
