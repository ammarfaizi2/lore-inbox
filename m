Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265809AbTL3Pl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 10:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbTL3Pl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 10:41:27 -0500
Received: from NPRI54MAI01.NPT.NUWC.NAVY.MIL ([164.223.1.100]:41228 "EHLO
	npri54mai01.npt.nuwc.navy.mil") by vger.kernel.org with ESMTP
	id S265809AbTL3PlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 10:41:25 -0500
Date: Tue, 30 Dec 2003 10:41:12 -0500
From: Pacheco Jason NPRI <PachecoJ@Npt.NUWC.Navy.Mil>
Subject: RE: 2.7 (future kernel) wish
To: " (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Message-id: <3BEEE23D31CAD2118D920008C75D8946059FF5AB@NPRI54EXC21.NPT.NUWC.NAVY.MIL>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>When you insert a device like a USB stick Windows puts a 
> >>little icon next to the clock in the system tray that you're 
> >>supposed to use to stop the device before pulling it, effectively 
> >>it unmounts and stops (or atleast releases the device from) 
> >>the driver so the device can be 'safely' removed.
> > 
> > 
> > This is useful, and something I think we need on the Linux 
> desktop (stay
> > tuned).
> > 
> 
> I agree, that's one of the reasons I posted at all. Little 
> things like 
> this can make a big difference, even though I've seen a lot 
> of users not 
> notice the little icon and have to be told about it.
> 
> Maybe when the icon appears have a tool-tip that pops up and says 
> something like "your USB device is ready for user at /mnt/usb, click 
> here when you're done" or something like that to make it more 
> noticable 
> that they shouldn't just yank it.
> 
> But I seem to be getting OT for this list...

Has anyone tried SuSE 9.0 (I believe the feature also exists in 8.2)?
It has a program called suseplugger that monitors hotswappable devices.
When I stick my USB key in it automatically detects and mounts the device
and presents an icon in KDE. It is very smooth and elegant, even more so
than in windows which pops up a bunch of "New Hardware Found" dialogs
each time you plug it into a different USB port for the first time. Also,
I unplugged the device a few times without unmounting it and there were
no complaints. In fact, I plugged it in again and was able to access the
files without having to remount it, Linux thought it was mounted the whole
time.

But I agree, OT, this is an interface issue.

-- P.S. Sorry Jim Crilly, set the To field wrong, my B
