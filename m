Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278296AbRJMOLg>; Sat, 13 Oct 2001 10:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278298AbRJMOL1>; Sat, 13 Oct 2001 10:11:27 -0400
Received: from dc-mx07.cluster0.hsacorp.net ([209.225.8.17]:13205 "EHLO
	dc-mx07.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S278296AbRJMOLT>; Sat, 13 Oct 2001 10:11:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Josh <selerius@charter.net>
Organization: http://www.codefusion.org
To: linux-kernel@vger.kernel.org
Subject: mouse stop responding in 2.4.12
Date: Sat, 13 Oct 2001 10:20:30 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101310203003.00164@slak>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all...I hope someone might know whats going on with my mouse since I 
upgraded the kernel to 2.4.12 from 2.4.6 (with a brief run in with 2.4.11)  
Here is what has happened so far.  I have about 4 computers all hooked 
together with a KVM (keyboard, video, mouse -- share the same keyboard, vid, 
and mouse with 4 seperate computers)  When i am running Xfree86 on this one 
particular linux box (one that got updated to 2.4.12) the mouse works 
fine...however, say I need to do work on another machine, so I flip a switch 
and do my work, but when I flip back to the linux box with X running, the 
mouse dies.  I have a Microsoft Intellimouse Optical, and it lights up red 
when its working from the optics inside...the light dies as well like I am 
not getting power to the mouse at all.  The only solution I can find to the 
problem is I have to switch (ctrl+alt+F3 for example) to a free tty, and then 
switch back into X, then the mouse lights up, and everything works.  But has 
is all of a sudden started doing this, and what can I do to fix it.  My KVM 
switch does not emulate the keyboard or mouse, and I was thinking of going 
out and buying a nice KVM that does full emulation of both devices.  Would 
this fix my problem.  Some other stuff I have done is changed the driver for 
the mouse in X, and also shortened the mouse cable thinking maybe the cable 
was too long for the signal to go though.  Any advise/solutions would be very 
appreciated.  Thanks Alot.

Josh
