Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVE0NAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVE0NAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVE0M61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:58:27 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:20419 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262468AbVE0M47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:56:59 -0400
Date: Fri, 27 May 2005 08:56:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.12-rc5 build failure
In-reply-to: <20050527124339.GA22605@pern.dea.icai.upco.es>
To: romano@dea.icai.upco.es, linux-kernel@vger.kernel.org
Message-id: <200505270856.44307.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200505260750.57571.gene.heskett@verizon.net>
 <200505260839.51153.gene.heskett@verizon.net>
 <20050527124339.GA22605@pern.dea.icai.upco.es>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 08:43, Romano Giannetti wrote:
>On Thu, May 26, 2005 at 08:39:51AM -0400, Gene Heskett wrote:
>> Aarrrhhggg... Thats about 150 chars longer than I can copy-paste
>> here.
>>
>> I'll wait for rc6 I think.
>>
>> >http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linu
>> >x-2
>> > .6.git;a=commitdiff;h=dca79a046b93a81496bb30ca01177fb17f37ab72;h
>> >p=5d af05fbf73fc199e7a93a818e504856d07c5586 -
>
>It would be nice to add a "shortlink this patch" feature to
> gitweb...have a link like 
> http://kernel.org/git/gitweb.cgi?slink=someASCIIhashof40char...
>
>Romano

OT probably...  So how does one go about getting 'gitweb'?

I now see a couple of .git files in the snapshots dir that I grabbed 
this morning:

[amanda@coyote src]$ ls -l |grep .git
-rw-r--r--    1 root    root           66398 May 26 09:01 patch-2.6.12-rc5-git1.gz
-rw-r--r--    1 root    root          196014 May 27  2005 patch-2.6.12-rc5-git2.gz

Do these include that fix?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
