Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTAKQCr>; Sat, 11 Jan 2003 11:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTAKQCr>; Sat, 11 Jan 2003 11:02:47 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:7899 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267278AbTAKQCq>; Sat, 11 Jan 2003 11:02:46 -0500
Date: Sat, 11 Jan 2003 11:09:47 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: 2.5.56 power off oddity
To: linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042301386.847.57.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I noticed last night with 2.5.56 and this may be unique to my
system.  I did a mostly default "make config" (changing only network,
usb, and sound settings from the default).  

What I noticed is that on shutdown, when it said "Power off" or whatever
it says when you "init 0", if I pressed my power button, it did not
immediately power down the computer.  I had to do the old "hold in the
power button for six seconds" trick for the power to shut off.

This was not the csae in the 2.4.20 kernels.

Maybe I need to tweek ACPI settings??  

By the way, noticed that I had to select Pentium 3 on the processor type
menu now as if I was using an antiquated system (Which I guess I am). 
The default kernel processor type was set to pentium 4.  Does this mean
future distros from vendors are likely to require a pentium 4 to run
since that's the default?  

-Rob

