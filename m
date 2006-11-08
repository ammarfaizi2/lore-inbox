Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965773AbWKHOTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965773AbWKHOTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965778AbWKHOTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:19:25 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:53335 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S965773AbWKHOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:19:24 -0500
Date: Wed, 08 Nov 2006 09:19:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.19-rc5
In-reply-to: <5a4c581d0611080159x381a9afdy26f3dd1f1ed704f1@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Message-id: <200611080919.06254.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <1162979018.12585.0.camel@nigel.suspend2.net>
 <5a4c581d0611080159x381a9afdy26f3dd1f1ed704f1@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 04:59, Alessandro Suardi wrote:
>On 11/8/06, Nigel Cunningham <ncunningham@linuxmail.org> wrote:
>> Gidday.
>>
>> On Tue, 2006-11-07 at 18:33 -0800, Linus Torvalds wrote:
>> > Ok, things are finally calming down, it seems.
>> >
>> > The -rc5 thing is mainly a few random architecture updates (arm,
>> > mips, uml, avr, power) and the only really noticeable one there is
>> > likely some fixes to the local APIC accesses on x86, which apparently
>> > fixes a few machines.
>> >
>> > The rest is really mostly one-liners (or close) to various
>> > subsystems. New PCI ID's, trivial fixes, cifs, dvb, things like that.
>> > I'm feeling better about this - there may be a -rc6, but maybe we
>> > don't even need one.
>> >
>> > As usual, thanks to everybody who tested and chased down some of the
>> > regressions,
>> >
>> >               Linus
>>
>> The patch etc doesn't seem to be available yet. (The front page is
>> still showing -rc4, for example).
>
>The patch is available, it's just the kernel.org home that
> isn't updated.
>
Tis now, I have it building.

>http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.19-rc5.bz2
>
>--alessandro
>
>"...when I get it, I _get_ it"
>
>     (Lara Eidemiller)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
