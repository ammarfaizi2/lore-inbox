Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbVDAPRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbVDAPRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 10:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVDAPRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 10:17:30 -0500
Received: from alog0177.analogic.com ([208.224.220.192]:42388 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262763AbVDAPRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 10:17:10 -0500
Date: Fri, 1 Apr 2005 10:16:39 -0500 (EST)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Renate Meijer <kleuske@xs4all.nl>
cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] : remove unreliable, unused and unmainained arch from
 kernel.
In-Reply-To: <f3db21ceb79616110118e303fe9a5db2@xs4all.nl>
Message-ID: <Pine.LNX.4.61.0504011001550.13262@chaos.analogic.com>
References: <11123574931907@2ka.mipt.ru> <Pine.LNX.4.61.0504010805130.12910@chaos.analogic.com>
 <f3db21ceb79616110118e303fe9a5db2@xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, Renate Meijer wrote:

>
> On Apr 1, 2005, at 3:09 PM, linux-os wrote:
>
>>
>> [PATCH snipped]
>>
>> Cruel joke. Now 80 percent of the Intel clones won't boot.
>> Those are the ones that run industry, you know, the stuff that
>> is necessary to earn money.
>>
>> Without i386 support, you don't have any embedded systems. You
>> need to use the garbage Motorola CPUs and the proprietary
>> operating systems in embedded stuff.
>
> Have you checked your calender yet?
>
> Besides... Never heard of ARM? Atmel has a complete line of those,
> which seem very usefull.

I'm quite aware of the date and time, thank you. The 'i386 architecture
is the Intel-like stuff that doesn't have all the newer gee-whiz
things that are of little value in the embedded area.

And, ARM is an exploded-cost over-hyped RISC device with poor I/O
capability that assumes that the world is interfaced in 32-bit
chunks. It also can't take advantage of the cost economies that
you get from the devices used in the PC mass-market like
memory-controllers, PCI-IO bridges and etc.

Although these are used in the new "high-definition" TVs I
can assure you that there are many more PC components being
manufactured now than high-definition TV sets. Eventually,
the ARM, or something that supersedes it might make sense.
Right not, forget it.

So, basically, you guys think you can single-handedly
remove Linux from the embedded market and re-do it just
for servers? Or are you going to leave some capability
for desk-tops, too?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
