Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUJOPxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUJOPxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUJOPxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:53:19 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:33710 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268064AbUJOPxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:53:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
Date: Fri, 15 Oct 2004 11:53:08 -0400
User-Agent: KMail/1.7
Cc: Josh Boyer <jdub@us.ibm.com>, root@chaos.analogic.com,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com> <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151153.08527.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.58.180] at Fri, 15 Oct 2004 10:53:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 October 2004 08:31, Josh Boyer wrote:
>On Fri, 2004-10-15 at 07:10, Richard B. Johnson wrote:
>> On Fri, 15 Oct 2004, Roman Zippel wrote:
>> > Hi,
>> >
>> > On Thu, 14 Oct 2004, David Howells wrote:
>> >> I've uploaded an updated module signing patch with Rusty's
>> >> suggested additions:
>> >
>> > Can someone please put this patch into some context, where it's
>> > not completely pointless? As is it does not make anything more
>> > secure. Why is the kernel more trustable than a kernel module?
>> > If someone could show me how I can trust the running kernel, it
>> > should be rather easy to extend the same measures to modules
>> > without the need for this patch.
>> >
>> > bye, Roman
>> > -
>>
>> This is just the first step, which I think must be quashed
>> immediately. The ultimate goal is to control what you put
>> into your computer. Eventually, some central licensing
>> authority will certify any modules that are allowed to
>> be run in your computer. Doesn't anybody else see this?
>
>cd linux-2.6;
>patch -R -p1 < ../<modsign patch name>
>
>josh
>
Yes, but what happens if it gets into the tarballs from kernel.org.

Stop this nonsense Linus, now.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
