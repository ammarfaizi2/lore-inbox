Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUAIF6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 00:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266301AbUAIF6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 00:58:52 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:39914 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S266283AbUAIF6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 00:58:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: <linux-kernel@vger.kernel.org>, sane-devel@lists.alioth.debian.org
Subject: 2.6.1-rc3 lost scanner, gnomeradio's gui segfaults
Date: Fri, 9 Jan 2004 00:58:49 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401090058.49513.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.61.108] at Thu, 8 Jan 2004 23:58:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greets everyone;

I'm setup to use libusb here, rahter than drivers/usb/scanner in the 
kernel config.

Up to 2.6.1-rc1-mm1 and possibly a little later, my scanner worked 
just fine.  But now on 2.6.1-rc3 its disappeared.

I also have everything in the i2c category except i2c-dev (builtin) as 
modules trying to find some combination that will let sensors run.
I had all that compiled in the last time it worked.

Also, gnomeradio just segfaulted on startup and left the radio on when 
it did.  That also worked previously.

Ideas?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

