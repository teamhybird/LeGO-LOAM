FROM hybird/x86_64/gtsam

COPY LeGO-LOAM/package.xml /home/catkin_ws/src/LeGO-LOAM/package.xml

COPY cloud_msgs/package.xml /home/catkin_ws/src/cloud_msgs/package.xml

RUN rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y

COPY . /home/catkin_ws/src/

SHELL ["bin/bash", "-c"]

RUN source /opt/ros/kinetic/setup.bash \
        && cd /home/catkin_ws \
        && echo '---HERE---' \
        && ls src \
        && catkin_make -j1

CMD cd /home/catkin_ws \
        && source devel/setup.bash \
        && sleep 5 \
        && roslaunch lego_loam run.launch

