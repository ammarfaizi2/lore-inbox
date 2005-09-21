Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVIUAnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVIUAnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVIUAnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:43:50 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:33010 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750834AbVIUAnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:43:49 -0400
Date: Tue, 20 Sep 2005 20:43:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Arrr! Linux v2.6.14-rc2
In-reply-to: <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl>
To: linux-kernel@vger.kernel.org
Message-id: <200509202043.48190.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200509201759.j8KHxkbj000577@laptop11.inf.utfsm.cl>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 September 2005 13:59, Horst von Brand wrote:
>Sean <seanlkml@sympatico.ca> wrote:
>> On Tue, September 20, 2005 10:25 am, Gene Heskett said:
>> > Humm, what are they holding out for, more ram or more cpu?:-)
>> >
>> > FWIW, http://master.kernel.org doesn't show it either just now.
>>
>> While kernel.org snapshots will no doubt be working again shortly, you
>> might want to consider using git.  It reduces the amount you have to
>> download for each release a lot.
>
>Only that it doesn't work either today. Kernel stays at 2.6.14-rc1 as of
>yesterday (latest were a few NTFS patches), everything up to date.

Thats odd.  I followed the directions in the message near the head of
this thread, and after I fixed my $PATH to include ~/bin:, it
just worked, and I made a copy of it to my /usr/src dir & built
it. I've been running 2.6.14-rc2 for about 00:02:17 now. And it seems
to be running nominally so far.  Or at least thats the version in the 
Makefile.  :-)

>BTW, the cogito repository is hosed, cg-update can't get needed object
>69ba00668be16e44cae699098694286f703ec61d. Fetching the contents by rsync
>gives the same mess.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

