Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUIDPSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUIDPSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 11:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUIDPSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 11:18:14 -0400
Received: from web53010.mail.yahoo.com ([206.190.39.200]:59817 "HELO
	web53010.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263743AbUIDPSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 11:18:07 -0400
Message-ID: <20040904151806.97975.qmail@web53010.mail.yahoo.com>
Date: Sat, 4 Sep 2004 08:18:06 -0700 (PDT)
From: Joseph Farmer <jfarmer99@yahoo.com>
Subject: DRM DRI and video
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, sorry for not posting directly to the thread,
I'm not subscribed.

>Keith Whitwell wrote on
>Date: Sat Sep 04 2004 - 06:23:33 EST
>Christoph Hellwig wrote:

>    On Sat, Sep 04, 2004 at 11:30:54AM +0100, Keith
>Whitwell wrote:

>            include a drm update. The last release
>RH-9 kernel has various security
>            and data integrity issues anyway, so
you'd >be a fool to keep running it.


>        OK, I've found www.kernel.org, and clicked on
>the 'latest stable kernel' link. I got a file called
>"patch-2.6.8.1.bz2". I tried to install this but
>nothing happened. My i915 still doesn't work. What do
>I do now? 

>    You could start getting a clue.


>You didn't stick with that long Christoph. We're not
>even past first base yet. Let's try again?

>So, I've got this file "patch-2.6.8.1.bz2". Lets
>suppose my older brother comes in & compiles it up
for >me & I'm now running 2.6.8.1 - it's implausible I
>know, but let's make it easier for you. Now, why
isn't >my i915 working?

>Keith
Clueless users do not download video drivers and
install them successfully.  Keith is stating that
having the drivers released with the kernel would
result in people not getting video driver updates fast
enough.  The contrary is in fact true.  The machine I
am on is Fedora Core 2.  It has:
vmlinuz-2.6.5-1.358,  vmlinuz-2.6.6-1.427,
vmlinuz-2.6.6-1.435, vmlinuz-2.6.6-1.435.2.3,
vmlinuz-2.6.7-1.494.2.2, and vmlinuz-2.6.8-1.521

I'm currently booted to 2.6.7-1.494 because I was dumb
enough to try to get the ATI driver working.  Part of
the install removed some GL stuff.  I fear when I boot
2.6.8-1 I'll be done.  I'm not even sure this machine
will run X after the next reboot.  This machine has an
ATI 9600 but the ATI driver didn't like the kernel I
have (patches to make it install via a number of
mailing lists were stupidly applied).  ATI 9600 with
ATI drivers and glxgears gives me:
360 frames in 5.0 seconds = 72.000 FPS
Wow.  This thing is now slower than it was with the
stock ATI driver.  Guess I messed something up pretty
bad.

I won't be messing with installing a video driver
again.  I'll take what Fedora gives me.  Instead of
multiple driver updated per kernel, I've tried 1 in
the time of about 5 kernels.  I'm not messing with my
other machine, I want it to work.

Include the drivers with the kernel.  I don't have to
pretend to be clueless like Keith did in his example. 
There is no way I'm going to download the latest DRI
if I can't even get the ATI driver working.

Sorry for the book.



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
