Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbUAZVMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 16:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAZVMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 16:12:22 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:48314 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S265223AbUAZVMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 16:12:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: gkrellm reports cpu temp*10! linux-athlon kernel=2.6.2-rc1-mm2
Date: Mon, 26 Jan 2004 16:12:17 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401261612.17942.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.53.166] at Mon, 26 Jan 2004 15:12:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all;

I just rebooted 2 days ago to 2.6.2-rc1-mm2, and I just now noticed 
that gkrellm is reporting my cpu at 680C.  Thats about 10x what its 
running at, still warm at 68C, but functional for 2 years now.  I 
didn't have this error under 2.6.1-rc2-mm4.
 
Any idea what patch to back out?  And where to get it?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
