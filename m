Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUI3UgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUI3UgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269494AbUI3UfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:35:16 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:37016 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S269474AbUI3UcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:32:19 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 16:32:17 -0400
User-Agent: KMail/1.7
Cc: Bill Davidsen <davidsen@tmr.com>
References: <pan.2004.09.30.04.53.05.120184@trippelsdorf.net> <200409300102.07373.gene.heskett@verizon.net> <cjhkfk$6bv$3@gatekeeper.tmr.com>
In-Reply-To: <cjhkfk$6bv$3@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409301632.17792.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 15:32:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 14:58, Bill Davidsen wrote:
>Gene Heskett wrote:
>> On Thursday 30 September 2004 00:53, Markus T. wrote:
>>># bzcat patch-2.6.9-rc3.bz2 | patch -p1
>>>...
>>>patching file fs/nfs/file.c
>>>Hunk #2 FAILED at 74.
>>>Hunk #3 FAILED at 91.
>>>2 out of 11 hunks FAILED -- saving rejects to file
>>> fs/nfs/file.c.rej ...
>>>
>>>___
>>>Markus
>>
>> And thats one of the reasons I never dl the bz2 version.
>>
>> You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
>> I just checked my scrollback and there is no such error here.
>
>Are you saying that he patched against the wrong kernel source
> because he pulled the bz2 patch? How do you make that leap? The gz
> patch does the same thing against the wrong source.

True, but my recommendation to use the .gz version is based on some 
pretty frustrating experiences encountered when using the .bz2 
versions that I haven't encountered with the .gz versions.  See my 
other, now a bit late reply to Clemens.  I was trying to hit both 
birds with one rock so to speak.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
