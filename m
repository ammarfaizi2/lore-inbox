Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131634AbRCSWL2>; Mon, 19 Mar 2001 17:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131636AbRCSWLS>; Mon, 19 Mar 2001 17:11:18 -0500
Received: from spike.i405.net ([63.229.23.90]:19718 "EHLO spike.i405.net")
	by vger.kernel.org with ESMTP id <S131634AbRCSWLD>;
	Mon, 19 Mar 2001 17:11:03 -0500
Message-ID: <3FA68C00B3E3A3418373DA6446330DD30328E0@spike.i405.net>
From: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
To: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        linux-kernel@vger.kernel.org
Subject: RE: Linux should better cope with power failure
Date: Mon, 19 Mar 2001 14:11:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto,

If you are doing development work (or playing with new kernels) and things
like USB failures lock you from keyboard and mouse...

Have you considered telnet into your box from a second machine?  Even a 486
system would do this fine... network cards are cheap.  You could try to
recover the system or at least do a shutdown.

Maybe there are reason you have ruled this out; just making sure you haven't
overlooked a possible prevention solution.

  Stephen Gutknecht
  Renton, Washington
  http://www.RoundSparrow.com/


-----Original Message-----
From: Otto Wyss [mailto:otto.wyss@bluewin.ch]
Sent: Monday, March 19, 2001 11:47 AM
To: linux-kernel@vger.kernel.org
Subject: Linux should better cope with power failure


Lately I had an USB failure, leaving me without any access to my system
since I only use an USB-keyboard/-mouse. All I could do in that
situation was switching power off and on after a few minutes of
inactivity. From the impression I got during the following startup, I
assume Linux (2.4.2, EXT2-filesystem) is not very suited to any power
failiure or manually switching it off. Not even if there wasn't any
activity going on. 
[snip]
