Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTKBVFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTKBVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:04:59 -0500
Received: from ulysses.news.tiscali.de ([195.185.185.36]:42251 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S261831AbTKBVE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:04:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Martin Wierich <wmartinw30@tiscali.de>
Newsgroups: linux.kernel,comp.os.linux.development.system,comp.os.linux.embedded,comp.os.linux.hardware,alt.comp.hardware.pc-homebuilt,alt.music-lover.audiophile.hardware,comp.sys.ibm.pc.hardware.storage,de.comp.hardware.laufwerke.festplatten,de.comp.os.unix.linux.hardware
Subject: turning off harddisk and listen music from ramdisk under Linux
Date: Sun, 02 Nov 2003 23:04:54 +0100
Organization: Tiscali Germany
Message-ID: <3FA57F86.7CEAC8A8@tiscali.de>
NNTP-Posting-Host: p62.246.106.170.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1067806795 22516 62.246.106.170 (2 Nov 2003 20:59:55 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Sun, 2 Nov 2003 20:59:55 +0000 (UTC)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I want to use a PC to listen mp3-music. Therefore I have to buy a new
harddisk.
I use Linux and I want to turn off all harddisks while listening,
because
they are so noisy. My plan is to let some homegrown software regularly
copy the music data
from a harddisk to a ramdisk and to turn off the harddisk then. Then I
would
listen from the ramdisk.

My questions:
 - is this possible?
 - how do I turn off a harddisk from software under Linux?
 - do I have to buy a special harddisk?
 - how does linux react on turning off all harddisks? Can
   I cut away any superfluous stuff like CRON and let Linux
   also run on a ramdisk? Or do I need some special embedded
   Linux distribution?
 - or is there a readymade solution?

There are the following circumstances:
 - for religious reasons I only use _old_ hardware (64MB, 100Mhz)
 - I am planning to have a boot partition just for the sole
   purpose of listening to music
 - I want to keep this boot partition small: no X windows stuff,
   no network and so on. The system should start up very
   fast.  
 - I have a SuSE Linux distribution on CD Rom. I only have a 56K
   modem. I don't want to download software for hours.

Any help would be appreciated.

cheers

  Martin
