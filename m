Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbULORDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbULORDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbULORDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:03:51 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:1734 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262396AbULORDq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:03:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: USB making time drift [was Re: dynamic-hz]
Date: Wed, 15 Dec 2004 12:03:44 -0500
User-Agent: KMail/1.7
References: <20041213002751.GP16322@dualathlon.random> <200412142159.23488.gene.heskett@verizon.net> <20041215091741.GA16322@dualathlon.random>
In-Reply-To: <20041215091741.GA16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151203.44679.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.42.94] at Wed, 15 Dec 2004 11:03:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 04:17, Andrea Arcangeli wrote:
>On Tue, Dec 14, 2004 at 09:59:23PM -0500, Gene Heskett wrote:
[...]
>The point is that this didn't happen with HZ=100, so it's not
that
>tickadj is wrong, it's the tick adjustment code that doesn't work.
>
>You may want to recompile your kernel with HZ=100 and verify it goes
>away (I didn't verify myself, but I verified the max irq latency I
> get is 4msec, and in turn I'm sure HZ=100 would fix it)

Ok, I was going to do that, but forgive me, its not in the .config
file as a setting.  So where do edit what to revert to 100hz's.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

