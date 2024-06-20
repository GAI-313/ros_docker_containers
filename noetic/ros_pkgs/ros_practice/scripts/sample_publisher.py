#!/usr/bin/env python3
from std_msgs.msg import Int32
import rospy

def main():
    rospy.init_node("sample_publisher")
    pub = rospy.Publisher("sample_number", Int32, queue_size=10)

    data = Int32()
    i = 0

    while not rospy.is_shutdown():
        data.data = i
        rospy.loginfo(f"Publish: {i}")
        i += 1
        pub.publish(data)
        rospy.sleep(1.0)

if __name__ == "__main__":
    main()
