Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131729AbRCOOV3>; Thu, 15 Mar 2001 09:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCOOVT>; Thu, 15 Mar 2001 09:21:19 -0500
Received: from gloworm.concentric.net ([207.155.248.5]:15281 "EHLO
	gloworm.cnchost.com") by vger.kernel.org with ESMTP
	id <S131729AbRCOOVG>; Thu, 15 Mar 2001 09:21:06 -0500
Message-ID: <200103151420.JAA03185@gloworm.cnchost.com>
From: Peter DeVries <peter@devries.tv>
To: linux-kernel@vger.kernel.org
Subject: Drvie Corruption CONSTANTLY with Linux and KT7-RAID
Date: Thu, 15 Mar 2001 06:20:24 -0800 (PST)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please help.. I'm at the end of my rope with this now.
 I have rebuilt this system and corupted my drive at
least 30 times now.  I have a ABIT KT7-RAID and no
matter what I do with any kernel 2.2.16 - 2.4.2-ac19
as soon as I turn on DMA mode the drive starts to
corrupt and becomes useless.  The corruption happens
alot faster in 2.4xxx than the 2.2.xxx kernels.  

The system DOES work flawlessly running windows in DMA
mode, which leads me to believe that I am not
experiencing a Hardware problem. 

I have tried every suggestion concerning the via
chipset on this site.  I've heard of many success
stories with this board. what am i doing wrong?!?!

At this point I am 100% lost.  any help would be
greatly appreciated.  I am willing to do any testing
of the system that anyone may need.  Currently I have
no working copy of linux on the sytem.  My normal
process to get running is to install slackware. 
download 2.4.2 and the latest ac patch.  Compile, add
ide=reverse to lilo, switch the hd over to the
highpoint hpt366 controller and reboot.  As soon as I
boot corruption begins and drive will be useless
within 10 minutes.  I have also tried leaving the HD
on the VIA82686a controller witht the same results. 
Also note I have tried IBM & MAXTOR UDMA100 drives as
well as IBM & WD UDMA66 Drives.  I have tried both 40
& 80 pin cables on the drives.  

Please cc me in your replies as I am not subscribed to
the list. 

Thank you in advance for any help
