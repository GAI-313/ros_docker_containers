#!/usr/bin/env python3
from std_msgs.msg import Int32
import rospy

def callback(data):
    i = data.data
    rospy.loginfo(f"Subscribe: {i}")

def main():
    rospy.init_node("sample_subscriber")
    sub = rospy.Subscriber("sample_number", Int32, callback)
    rospy.spin()

if __name__ == "__main__":
    main()
