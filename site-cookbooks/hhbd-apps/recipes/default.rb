#
# Cookbook Name:: hhbd-apps
# Recipe:: default
#
# Copyright 2015, Jakub Kułak
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'jku-common'
include_recipe 'jku-nodejs'

include_recipe 'hhbd-apps::apache'

include_recipe 'jku-mysql::mysql_server'

include_recipe 'jku-php::default'

# Additional PHP modules
# package 'php5-gd'
package 'php5-mysql'
package 'php5-common'
# package 'php5-curl'
# package 'php5-memcache'
