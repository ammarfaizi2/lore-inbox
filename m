Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCFU6H>; Tue, 6 Mar 2001 15:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRCFU56>; Tue, 6 Mar 2001 15:57:58 -0500
Received: from relay01.cablecom.net ([62.2.33.101]:47112 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S129469AbRCFU5q>; Tue, 6 Mar 2001 15:57:46 -0500
Message-ID: <3AA54F40.A3643F3E@bluewin.ch>
Date: Tue, 06 Mar 2001 21:57:36 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB-keyboard not recognize after connection
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an USB-keyboard/-mouse connected to a switchbox which is itself
connected to a PowerMac (MacOS) and my PC running Linux. I do regularly
switch my USB-devices between Mac and PC. Since I upgraded to kernel
2.4.0 and now 2.4.2 it happens from time to time that Linux does not
recognize my keyboard/mouse after switching back to the PC. This leaves
me in a rather unconfortable situation, since I can't do anything
anymore. All I could do is switch off the power! I tried to
disconnect/reconnect my USB-keyboard but it didn't help.

My questions:

1. Is there any better way to fix this situation, besides power off or
getting a standard keyboard?

2. Is there a minmal time frame of no activity (up to an hour) where any
cached data is saved to the disk, so I could switch off the power
without corrupting my disk?

3. How can I get more information what's happening? Is there any
USB-log/-trace accessable after the restart of linux? And whom/where do
I have to send it?

O. Wyss

PS. Please do CC, I don't read linux-kernel.
