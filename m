Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271416AbUJVQPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271416AbUJVQPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271418AbUJVQPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:15:38 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:55976 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S271416AbUJVQPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:15:34 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, root@chaos.analogic.com
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
Date: Fri, 22 Oct 2004 12:15:32 -0400
User-Agent: KMail/1.7
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>, umbrella@cs.aau.dk
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost> <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221215.32597.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.58.180] at Fri, 22 Oct 2004 11:15:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 11:07, Richard B. Johnson wrote:
>while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ;
> vmstat ; done

Stable, yes.  But only after about 3 or 4 iterations.  The first 3 
rather handily used 500+ megs of memory that I did not get back when 
I stopped it and cleaned up the mess.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
