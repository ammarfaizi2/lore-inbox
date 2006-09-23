Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWIWOsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWIWOsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 10:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWIWOsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 10:48:15 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:43937 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751222AbWIWOsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 10:48:14 -0400
Date: Sat, 23 Sep 2006 10:48:13 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19 -mm merge plans
In-reply-to: <358885143.12940@ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@gmail.com>, Andrew Morton <akpm@osdl.org>
Message-id: <200609231048.13154.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060920135438.d7dd362b.akpm@osdl.org>
 <20060921165918.af7a5a63.akpm@osdl.org> <358885143.12940@ustc.edu.cn>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 September 2006 20:32, Fengguang Wu wrote:
>On Thu, Sep 21, 2006 at 04:59:18PM -0700, Andrew Morton wrote:
>> > On Wed, Sep 20, 2006 at 01:54:38PM -0700, Andrew Morton wrote:
>> > >  The readahead code is complex, I'm unconvinced that it has a lot
>> > > of benefit and Wu has gone quiet.  Will drop.
>> >
>> > Sorry, I've been putting efforts to meet the deadline of the google
>> > SoC project "Rapid linux desktop startup through pre-caching", which
>> > still can not be called success for now. And there's my pending paper
>> > work...
>>
>> Oh, OK.
>>
>> That's a neat thing to be working on.
>
>Thank you.
>
>FYI: I attached a little presentation work, one for the boot time
>stuff, another for the readahead patch.
>
>> > I should be able to come back and concentrate on the readahead patch
>> > after one month, whether it be dropped for now.  I guess it can be
>> > further improved in complexity and performance.  It also needs a good
>> > document for the overall design and benefits.  And sure the
>> > performance numbers :-)
>>
>> I'll hang onto the patches then - they're causing little maintenance
>> trouble for me.
>
>Sorry, I can imagine it, which upsets me.
>I'll try to settle it in the next 3-month cycle.
>
>Thanks,
>Fengguang Wu

Both of your attached pdf's were missing the required fonts to display the 
content on this locale=en machine, as the latest acroread for linux (7.05) 
advised me about both, and the second one, while it did display the cover 
page in english at a scale far larger than my 1600x1200 screen, it 
actually locked up X and I had to reboot.  I thought I had enough fonts 
here to cover everything too.  :(

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
