Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbULRAjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbULRAjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 19:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbULRAjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 19:39:07 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:27040 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S262366AbULRAiH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 19:38:07 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, sboyce@blueyonder.co.uk
Subject: Re: 2.6.10-rc3 vs clock
Date: Fri, 17 Dec 2004 19:38:05 -0500
User-Agent: KMail/1.7
References: <41C3746D.8090308@blueyonder.co.uk>
In-Reply-To: <41C3746D.8090308@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412171938.05269.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.47.244] at Fri, 17 Dec 2004 18:38:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 December 2004 19:06, Sid Boyce wrote:
>Bill Davidsen wrote:
>
>Gene Heskett wrote:
>
>clocks...
>
>Gene Heskett suggested I play around with tickadj and I found that a
>value of 9962 on this SuSE 9.2/XP3000+ has kept it rock solid over
> the last 4 days. On the x86_64 laptop with XP3000+-Mobile, it's
> never been out, both of them running 2.6.10-rc3 and using ntpd to
> keep in step. On the other box with Mandrake 10.1/XP2800+ and
> 2.6.10-rc3, I had to set it to 9958. Something has definitely
> changed with 2.6.10-rc3.
>Regards
>Sid.

Thats not as far off as I was here Sid. I have to use 9926 on this
box, an XP2800 athlon with a gig of ram, and high mem turned on.

And your quoting mechanism in that MTA is broken Sid. :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

