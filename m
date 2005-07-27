Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVG0DZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVG0DZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 23:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVG0DZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 23:25:05 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:32932 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S262069AbVG0DZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 23:25:03 -0400
Date: Tue, 26 Jul 2005 23:25:02 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Question re the dot releases such as 2.6.12.3
In-reply-to: <1122429050.29823.44.camel@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Message-id: <200507262325.02186.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200507251020.08894.gene.heskett@verizon.net>
 <20050727012853.GA2354@kurtwerks.com>
 <1122429050.29823.44.camel@localhost.localdomain>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 July 2005 21:50, Steven Rostedt wrote:
>On Tue, 2005-07-26 at 21:28 -0400, Kurt Wall wrote:
>> On Mon, Jul 25, 2005 at 12:38:43PM -0400, Brian Gerst took 21 lines 
to write:
>> > Gene Heskett wrote:
>> > >Greetings;
>> > >
>> > >I just built what I thought was 2.6.12.3, but my script got a
>> > > tummy ache because I didn't check the Makefile's
>> > > EXTRA_VERSION, which was set to .2 in the .2 patch.  Now my
>> > > 2.6.12 modules will need a refresh build. :(
>> > >
>> > >So whats the proper patching sequence to build a 2.6.12.3?
>> >
>> > The dot-release patches are not incremental.  You apply each one
>> > to the base 2.6.12 tree.
>>
>> This bit me a while back, too. I'll submit a patch to the
>> top-level README to spell it out.
>
>Someone should also fix the home page of kernel.org. Since there's
> no link on that page that points to the full 2.6.12. Since a lot of
> the patches on that page go directly against the 2.6.12 kernel and
> not 2.6.12.3, it would be nice to get the full source of that
> kernel from the home page.
>
Apparently you are useing a browser to suck that stuff?  Use gftp and 
walk right up the dir structure to it.  Its not hidden at all that 
way.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
