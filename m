Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTKMMan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKMMan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:30:43 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:4015 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S263934AbTKMMam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:30:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: idle processes maybe?
Date: Thu, 13 Nov 2003 07:30:38 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311130730.38036.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.12.17] at Thu, 13 Nov 2003 06:30:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a comment about 2.6.0-test9-mm2, using elevator=deadline

So far, almost everything is working very very well, thanks guys.  
I've been running test9-mm2 for most of its life.  But mm3 is 
building right now, thanks Andrew.

One minor thing.  Playing some music I'd just ripped to ogg's, using 
xmms, about 1 in 20 refused to play, like the ogg player didn't 
start.  Quitting and restarting xmms moved the no-play to another 
song or songs.  Nothing reported in the logs.  I also realise this 
isn't anywhere near enough info, more of a trivia detail, to be 
recalled if someone else reports something similar.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

