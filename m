Return-Path: <linux-kernel-owner+w=401wt.eu-S932920AbWL0GCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920AbWL0GCm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 01:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWL0GCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 01:02:42 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:20031 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbWL0GCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 01:02:41 -0500
Date: Wed, 27 Dec 2006 01:02:23 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: System / libata IDE controller woes (long)
In-reply-to: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAANz30GbAA9BLm2+8fOoz0KkBAAAAAA==@EchoHome.org>
To: linux-kernel@vger.kernel.org, Erik@echohome.org
Cc: "'Tejun Heo'" <htejun@gmail.com>
Message-id: <200612270102.27619.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAANz30GbAA9BLm2+8fOoz0KkBAAAAAA==@EchoHome.org>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 00:50, Erik Ohrnberger wrote:
>Hi There!
>	Yea, I thought that it might be power related as well, so I moved
>1/2 of the drives from the 500 Watt power supply onto a separate one,
> and it did not change any of the symptoms.  So I think that it's been
> ruled out.
>
>	Thanks,
>		Erik.

Cable lengths can be a bear too, particularly if the drive set as master 
is NOT on the end connector of the cable.

>> Hello,
>>
>> Erik Ohrnberger wrote:
>> > Earlier this year, when I started putting it together, I
>>
>> gathered my
>>
>> > hardware.  A decent 2 GHz Athlon system with 512 MB RAM,
>>
>> DVD drive, a
>>
>> > 40 GB system drive, and a 500 Watt power supply.  Then I started
>> > adding hard disks.  To date, I've got 5 80 GB PATA, 2 200
>>
>> GB PATA, and 1 60 GB PATA.
>>
>> That's 9 hard drives.  How did you hook up your power supply?
>>  My dual-rail 450w PS has a lot of problem driving 9 drives
>> no matter how I hook it up while my 350w power supply can
>> happily handle the load.  I suspect it's because how the
>> separate 12v rails are configured in the PS.
>>
>> It's nothing concrete but I wanna rule PS issue first.  If
>> you've got an extra power supply (buy cheap 350w one if you
>> don't have one), hook half of the drives to it and see what
>> happens.  Using PS without motherboard is easy.  Just ask google.
>>
>> Happy holidays.
>>
>> --
>> tejun
>
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
