Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUA3QZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUA3QZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:25:52 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:36003 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261837AbUA3QZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:25:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: 2.6.2-rc2-mm2
Date: Fri, 30 Jan 2004 11:25:48 -0500
User-Agent: KMail/1.6
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <20040130014108.09c964fd.akpm@osdl.org> <20040130111435.GB2505@babylon.d2dc.net>
In-Reply-To: <20040130111435.GB2505@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401301125.48632.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.53.166] at Fri, 30 Jan 2004 10:25:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 January 2004 06:14, Zephaniah E. Hull wrote:
>On Fri, Jan 30, 2004 at 01:41:08AM -0800, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.
>>2-rc2/2.6.2-rc2-mm2/
>>
>>
>> - I added a few late-arriving patches.  Usually this breaks
>> things.
>>
>> - Added a few external development trees (USB, XFS).
>>
>> - PNP update
>
>This patch contains:
>--- linux-2.6.2-rc2/./include/linux/sched.h	2004-01-25
> 20:49:43.000000000 -0800 +++ 25/./include/linux/sched.h	2004-01-29
> 23:27:45.000000000 -0800 ...
>--- linux-2.6.2-rc2/include/linux/sched.h	2004-01-25
> 20:49:43.000000000 -0800 +++ 25/include/linux/sched.h	2004-01-29
> 23:27:45.000000000 -0800
>
>Both of which seem to be the exact same patch.
>
>This obviously causes some problems when applying.

Thanks, I took the second copy out and it went ok.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
