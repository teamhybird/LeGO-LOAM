FROM ros:kinetic-ros-core

COPY . /home/catkin_ws/src/

RUN apt-get -qq update && apt-get install -y sudo cmake libboost-all-dev

# uhh should fork and tag this?
RUN git clone https://bitbucket.org/gtborg/gtsam.git /home/gtsam \
        && cd /home/gtsam \
        && mkdir build \
        && cd build \
        && cmake .. \
        && make install

RUN rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y

SHELL ["bin/bash", "-c"]

RUN source /opt/ros/kinetic/setup.bash \
        && cd /home/catkin_ws/ \
        && catkin_make

CMD cd /home/catkin_ws \
        && source devel/setup.bash \
        && roslaunch lego_loam run.launch

