Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131893AbRCVDJz>; Wed, 21 Mar 2001 22:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbRCVDJq>; Wed, 21 Mar 2001 22:09:46 -0500
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:20886 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S131893AbRCVDJ2>; Wed, 21 Mar 2001 22:09:28 -0500
Date: Wed, 21 Mar 2001 21:08:34 -0600 (CST)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: Kernel-mailing list <linux-kernel@vger.kernel.org>
Subject: Sound issues with m805lr motheboard
Message-ID: <Pine.LNX.4.30.0103212050580.3677-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My LUG has had a machine donated with a PC Chips M805LR Motherboard (info
here http://www.eurocomla.com/m805lr.htm)  I have to get it working to
stream our meetings with realserver.  as such I cannot use the new 2.4
kernels with it since Realserver won't work with them.  I am having
trouble with the kernel drivers for its onboard sound card.  I have
compiled the driver for the VIA 82C686 and I can get sound, but it will
not recognize the line-in port.  If I use a 2.4 kernel on the machine then
it works fine, but I can't run the realserver with it.  Is this a known
issue with the VIA drivers in the 2.2.xx (i am using 2.2.18)? if so is
there a work around for it?  Any info would be helpful.
thanks,
Brent Norris

System Admin - 	WKU-Center for BioDiversity (4)
		WKU-Linux (3)
		Best Mechanical (3)


