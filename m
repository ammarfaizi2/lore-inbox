Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUBBE7r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 23:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265621AbUBBE7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 23:59:47 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:12480 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S265620AbUBBE7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 23:59:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: hotplug question
Date: Sun, 1 Feb 2004 23:59:45 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402012359.46020.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.53.166] at Sun, 1 Feb 2004 22:59:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

About a week ago I did and rm -fR on the hotplug stuffs because it was 
totally hanging the boot for some reason.

Tonight I re-installed it and did a test reboot to 2.6.2-rc3.  When it 
got to "Starting hotplug", the init script sat there for around 30 
seconds, and eventually said OK.  It did load the one module I have 
set as a module, for the pl-2303 seriel to usb adaptor.  Or at least 
I didn't have to do it by hand with modprobe.

Is this huge, even worse than kudzu, boot delay normal for hotplug?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
