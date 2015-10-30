#
# Cookbook Name:: hhbd-apps
# Recipe:: apache
#
# Copyright 2015, Jakub Kułak
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Change Apache2 listening port if there Varnish backend_port defined
node.default['apache']['listen_ports'] = [node['varnish']['backend_port']] if defined?(node['varnish']['backend_port'])

include_recipe "jku-apache::default"
