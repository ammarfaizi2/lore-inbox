Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVE1SVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVE1SVu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVE1SVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 14:21:49 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:46721 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261175AbVE1SVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 14:21:47 -0400
Date: Sat, 28 May 2005 14:21:46 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Question re .git# patches
In-reply-to: <20050528105333.12a7e28b.rdunlap@xenotime.net>
To: linux-kernel@vger.kernel.org
Message-id: <200505281421.46572.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200505281050.24956.gene.heskett@verizon.net>
 <20050528105333.12a7e28b.rdunlap@xenotime.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 13:53, randy_dunlap wrote:
>On Sat, 28 May 2005 10:50:24 -0400 Gene Heskett wrote:
>| Are these self-contained, so that .git2 also contains the .git1
>| contents?
>
>Yes, and today's -git3 contains both of those.
>
I see.  I also tried to put Ingo's latest RT patch on top of that, it 
went in except for the Makefile, wrong src version, but then the 
Makefile itself was broken with some mumbling about make 
modules_install failing because ln claimed the last argument was 
bogus. I couldn't see anything wrong with the version names I used, 
they were indentical in both the Makefile and in my 'makeit' script.

Running git2, seems to be happy so far (about 20 minutes)

Anything in particular that I should be watching for?

>---
>~Randy

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
