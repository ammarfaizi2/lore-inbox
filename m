Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUKCMvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUKCMvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbUKCMvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:51:44 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:39127 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261576AbUKCMvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:51:41 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 07:51:39 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411030751.39578.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 06:51:40 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I thought I'd get caught up on -bkx kernels and made a -bk8 just now.

But I'd tried to run gnomeradio earlier to listen to the elections, 
but it failed leaving to run, as did tvtime then too, claiming it 
couldn't get a lock on /dev/video0, and gnomeradio apparently left a 
lock on alsasound that prevented the normal gracefull shutdown by 
locking up the shutdown on the "stopping alsasound" line.  So I had 
to use the hardware reset.

I'd tried to kill the zombie earlier but couldn't.

Isn't there some way to clean up a &^$#^#@)_ zombie?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
