Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTA3UXG>; Thu, 30 Jan 2003 15:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTA3UXG>; Thu, 30 Jan 2003 15:23:06 -0500
Received: from mta05bw.bigpond.com ([139.134.6.95]:13295 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S266100AbTA3UXF>; Thu, 30 Jan 2003 15:23:05 -0500
Message-ID: <3E398BF0.65C32CFE@bigpond.net.au>
Date: Fri, 31 Jan 2003 06:32:48 +1000
From: Chris Ison <cisos@bigpond.net.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20-ac1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Radeon PCI support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for any information that may help in getting my Radeon PCI
card working in linux with acceloration.

I am in the process of trying to obtain information from ATI about the
chipset but apart from that I haven't been successful in any other way
except I have determined the card becomes locked and often its FIFO read
pointer is occassionally at 0 when it has locked (with the FIFO write
pointer often several kilobytes ahead of it).

I have had no luck with DRI or XFree86 people as PCI support for Radeons
on x86 platform isn't a priority at this time.

The suggestion is that the problem is in the DRM but I can't find
information confirming that in the lkml at this time.

If you do have any information/patches that could help for the x86
platform could you please CC me as I am not on the lkml due to its
traffic volume.

I am determined to have this fixed so please help if you can.


Thank you in advance
Chris Ison
