Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268264AbRGWPYl>; Mon, 23 Jul 2001 11:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbRGWPYb>; Mon, 23 Jul 2001 11:24:31 -0400
Received: from woodynet.siscom.net ([209.251.13.244]:45478 "EHLO hackswell.com")
	by vger.kernel.org with ESMTP id <S268264AbRGWPYQ>;
	Mon, 23 Jul 2001 11:24:16 -0400
Date: Mon, 23 Jul 2001 11:24:30 -0400 (EDT)
From: Sir Woody Hackswell <woody@hackswell.com>
To: <linux-kernel@vger.kernel.org>
Subject: Athlon and 2.4.x not booting
Message-ID: <Pine.LNX.4.33.0107231120001.8449-100000@hackswell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello, all!

I have RedHat7.1, and an athlon 1.0GHz on an ASUS with ALi chipset (ASUS
A7A266 DDR), and I've been having problems getting my kernel configured
properly.  I've tried using the gcc 2.96 that comes with RH7.1 and also some
rpms of gcc 3.0 to no success.

If I compile 2.4.x as a K6-III, my machine will boot fine, but when I try to
optimize the kernel and compile it as Athlon, I compile fine with no
warnings, but when I install the kernel and boot, I decompresses the kernel
and hangs. No errors, no crash dump - nothing.

Is there a problem with my hardware?  Or is this a known problem?  Any way
to turn on more debugging?  Thanks!

-Woody!


-----
There is no OS but Linux,
and Torvalds is its prophet.
(Peace be upon His soul)

Sir.Woody@Hackswell.com       http://sir.woody.hackswell.com

