Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUDLIHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUDLIHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 04:07:20 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:19946 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S262831AbUDLIHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 04:07:12 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: alsa babbling starting with 2.6.5-mm1 thru mm4
Date: Mon, 12 Apr 2004 04:07:10 -0400
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120407.10796.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.9.226] at Mon, 12 Apr 2004 03:07:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

My messages log is being drowned in this message, and has been since 
2.6.5-mm1's first bootup:
Apr  6 15:57:56 coyote kernel: ALSA sound/pci/via82xx.c:727: invalid 
via82xx_cur_ptr, using last valid pointer
Apr  6 15:58:28 coyote last message repeated 48 times
Apr  6 16:09:00 coyote last message repeated 71 times
Apr  6 16:11:39 coyote last message repeated 89 times
Apr  6 16:12:02 coyote last message repeated 32 times

And its continueing as I type, just rebooted to 2.6.5-mm4 about 10 
minutes ago.
Apr 12 03:27:44 coyote kernel: ALSA sound/pci/via82xx.c:727: invalid 
via82xx_cur_ptr, using last valid pointer
Apr 12 03:28:16 coyote last message repeated 16 times
Apr 12 03:30:04 coyote last message repeated 61 times
Apr 12 03:31:07 coyote last message repeated 80 times
Apr 12 03:32:15 coyote last message repeated 20 times
Apr 12 03:37:58 coyote last message repeated 70 times
Apr 12 03:40:04 coyote last message repeated 82 times
Apr 12 03:49:20 coyote last message repeated 70 times

alsa is 1.0.4

Ideas?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
