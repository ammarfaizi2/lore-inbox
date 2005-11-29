Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVK2XIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVK2XIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVK2XIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:08:18 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:50602 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S964804AbVK2XIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:08:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=coUVdks+MoYMELkRtkX3LNYxytvZQXOZkQ1gbuaQeHuUvtKVgSfZwDL3LYAfFwp4;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <036c01c5f539$c54bd730$1225a8c0@kittycat>
From: "jdow" <jdow@earthlink.net>
To: "Nick Warne" <nick@linicks.net>, "Wakko Warner" <wakko@animx.eu.org>
Cc: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <200511242147.45248.nick@linicks.net> <438B89EE.9080707@tmr.com> <20051129003159.GA4643@animx.eu.org> <200511292226.49873.nick@linicks.net>
Subject: Re: [OT] 1500 days uptime.
Date: Tue, 29 Nov 2005 15:08:10 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711201c517f81bd741014e289860ee379f3869360953d103349af350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.179.184
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Nick Warne" <nick@linicks.net>

> On Tuesday 29 November 2005 00:31, Wakko Warner wrote:
>> Bill Davidsen wrote:
>> > Nick Warne wrote:
>> > >Hi all,
>> > >
>> > >BrrrrrrrrrrrrBrrrr
>> > >
>> > >That was me blowing my own trumpet again :-)
>> > >
>> > >Re:
>> > >http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/0651.html
>> > >
>> > >Now just hit 1500 days:
>> > >
>> > >-
>> > >[nick@486Linux nick]$ last -xf /var/run/utmp runlevel
>> > >runlevel (to lvl 3)                    Sun Oct 14 16:07 - 21:41
>> > >(1502+06:34)
>> > >
>> > >utmp begins Sun Oct 14 16:07:40 2001
>> > >-
>> > >
>> > >Utterly remarkable - the box gets no maintenance at all.
>> >
>> > But it clearly gets a very reliable flavor of electricity...
>> >
>> > >I would love to know how much data it has delivered, but alas, in 2001 I
>> > >wasn't up-to-speed with that sort of thing :-)
>> >
>> > We got one to 1460 or so, then got BSOD on the controller which switches
>> > from the UPS to the diesel when they get up to speed, dropped power on
>> > the whole data center (at work).
>> >
>> > I think you have the record, though.
>>
>> I'm not sure about that one. =)
> 
> No, I wasn't even thinking that - just reporting what a wonderful job it all 
> is - and yes, power supply here in Pompey UK is good (but we do pay thru' the 
> nose for everything in the UK).  The last time I _did_ reboot that machine 
> was when my kettle lead shorted out and blew the fuses to my flats 240v 
> supply ring main.
> 
> According to the Linux counter site, there are more higher (my machine is 3rd 
> in the list):
> 
> http://counter.li.org/reports/uptimestats.php

There is an interesting point here that is worth noting. I don't think I
would BEGIN to try this with a 2.6 based kernel. And I am not sure it is
doable yet with a 2.4 kernel if the machine is to be exposed to the wild.

{o.o}    Joanne Dow

