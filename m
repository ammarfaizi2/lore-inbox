Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUJRPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUJRPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUJRPj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 11:39:28 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:20641 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266704AbUJRPjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 11:39:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: -final, a huge keyboard lag is back
Date: Mon, 18 Oct 2004 11:39:16 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410181139.16083.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.58.180] at Mon, 18 Oct 2004 10:39:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

for the last 3 or 4 minor revisions, and 3 different kde installs I 
have had a situation wherein the keyboard repeat goes down to less 
than 1 per second, making it very difficult to go back and fix the 
typu's my ancient fingers inevitably make.  The effect came and went 
at seemingly random times.

I hadn't noticed the effect during the approaches to final, -rc4 in 
particular maintained its snappiness from the keyboard very well.

This is not accompanied by an observable amount of cpu usage either.  
But its back, sometimes non-stop for several minutes at a time with 
-final.  I have NDI where to look, so I'll leave that to those that 
breath src code in their sleep.  In this sense, I'm a dumb beta 
tester making a use/feel report.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
