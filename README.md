# Mailbox Demo

This is a demo of the Mailbox iOS app. Here are the [instructions](http://courses.codepath.com/courses/ios_for_designers/unit/3#!assignment) for creating this demo.

Time spent: 

## Completed user stories:

* On dragging the message right...
   * Initially, the revealed background color is gray.
   * As the archive (check mark) icon is revealed, it is at first semi-transparent and then becomes fully opaque. If released at this point, the message returns to its initial position.
   * After 60 pts, the archive icon starts moving with the translation and the background changes to green.
     * Upon release, the message continues to reveal the green background. When the animation is complete, it hides the message.
   * After 260 pts, the icon changes to the delete icon ('x' mark) and the background color changes to red.
     * Upon release, the message continues to reveal the red background. When the animation is complete, it hides the message.
* On dragging the message left...
   * Initially, the revealed background color is gray.
   * As the reschedule icon (clock illustration) is revealed, it is at first semi-transparent and the becomes fully opaque. If released at this point, the message returns to its initial position.
   * After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
     * Upon release, the message continues to reveal the yellow background. When the animation is complete, it shows the reschedule options.
   * After 260 pts, the icon changes to the list icon and the background color changes to light brown.
     * Upon release, the message continues to reveal the light brown background. When the animation is complete, it shows the list options.
   * User can tap to dismiss the reschedule or list options. After the reschedule or list options are dismissed, the message finishes the hide animation.
* _Optional:_ Tapping on compose should animate to reveal the compose view.
   * Only works when simulator is run on a device with a mail account set up, but you can see the  

## Walkthrough of all user stories: 
_(minus the compose view, which only works on a device)_

![tada Mailbox demo gif](https://raw.githubusercontent.com/lizthebiz/mailbox-demo/master/lizdalay-mailbox.gif)

*GIF created with [LiceCap](http://www.cockos.com/licecap/).*
