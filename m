Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVLBCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVLBCiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVLBCiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:38:24 -0500
Received: from mail.tmr.com ([64.65.253.246]:17556 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964806AbVLBCiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:38:24 -0500
Message-ID: <438FB671.9060701@tmr.com>
Date: Thu, 01 Dec 2005 21:50:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jdow <jdow@earthlink.net>
CC: Nick Warne <nick@linicks.net>, Wakko Warner <wakko@animx.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] 1500 days uptime.
References: <200511242147.45248.nick@linicks.net> <438B89EE.9080707@tmr.com> <20051129003159.GA4643@animx.eu.org> <200511292226.49873.nick@linicks.net> <036c01c5f539$c54bd730$1225a8c0@kittycat>
In-Reply-To: <036c01c5f539$c54bd730$1225a8c0@kittycat>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdow wrote:

> From: "Nick Warne" <nick@linicks.net>
>
>> On Tuesday 29 November 2005 00:31, Wakko Warner wrote:
>>
>>> Bill Davidsen wrote:
>>> > Nick Warne wrote:
>>> > >Hi all,
>>> > >
>>> > >BrrrrrrrrrrrrBrrrr
>>> > >
>>> > >That was me blowing my own trumpet again :-)
>>> > >
>>> > >Re:
>>> > >http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/0651.html
>>> > >
>>> > >Now just hit 1500 days:
>>> > >
>>> > >-
>>> > >[nick@486Linux nick]$ last -xf /var/run/utmp runlevel
>>> > >runlevel (to lvl 3)                    Sun Oct 14 16:07 - 21:41
>>> > >(1502+06:34)
>>> > >
>>> > >utmp begins Sun Oct 14 16:07:40 2001
>>> > >-
>>> > >
>>> > >Utterly remarkable - the box gets no maintenance at all.
>>> >
>>> > But it clearly gets a very reliable flavor of electricity...
>>> >
>>> > >I would love to know how much data it has delivered, but alas, in 
>>> 2001 I
>>> > >wasn't up-to-speed with that sort of thing :-)
>>> >
>>> > We got one to 1460 or so, then got BSOD on the controller which 
>>> switches
>>> > from the UPS to the diesel when they get up to speed, dropped 
>>> power on
>>> > the whole data center (at work).
>>> >
>>> > I think you have the record, though.
>>>
>>> I'm not sure about that one. =)
>>
>>
>> No, I wasn't even thinking that - just reporting what a wonderful job 
>> it all is - and yes, power supply here in Pompey UK is good (but we 
>> do pay thru' the nose for everything in the UK).  The last time I 
>> _did_ reboot that machine was when my kettle lead shorted out and 
>> blew the fuses to my flats 240v supply ring main.
>>
>> According to the Linux counter site, there are more higher (my 
>> machine is 3rd in the list):
>>
>> http://counter.li.org/reports/uptimestats.php
>
>
> There is an interesting point here that is worth noting. I don't think I
> would BEGIN to try this with a 2.6 based kernel. And I am not sure it is
> doable yet with a 2.4 kernel if the machine is to be exposed to the wild.
>
> {o.o}    Joanne Dow
>
I got 0.99.4 to stay up 16 weeks ;-)

And the old GE/Honeywell 600 crashed due to rollover at 35 days, and we 
hit the bug first three years after it was coded. Hardware is better!

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

