Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbSLSSBF>; Thu, 19 Dec 2002 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSLSSBF>; Thu, 19 Dec 2002 13:01:05 -0500
Received: from zeke.inet.com ([199.171.211.198]:37265 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S265857AbSLSSA4>;
	Thu, 19 Dec 2002 13:00:56 -0500
Message-ID: <3E020B37.4070409@inet.com>
Date: Thu, 19 Dec 2002 12:08:55 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
References: <200212191800.gBJI03ZT002284@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>Following on from yesterday's discussion about there not being much
>>>interaction between the kernel Bugzilla and the developers, I began
>>>wondering whether Bugzilla might be a bit too generic to be suited to
>>>kernel development, and that maybe a system written from the ground up
>>>for reporting kernel bugs would be better?
>>>
>>>I.E. I am prepared to write it myself, if people think it's
>>>worthwhile.
>>
>>Quoting Linus
>>(http://marc.theaimsgroup.com/?l=linux-kernel&m=103911905214446&w=2):
>>
>>>And many things _can_ be done without throwing out old designs.
>>>Implementation improvements are quite possible without trying to make
>>>something totally new to the outside. ...
>>>
>>>Not throwing out the baby with the bath-water doesn't mean that you cannot
>>>improve the system. I'm only arguing against stupid people who think they
>>>need a revolution to improve - most real improvements are evolutionary.
>>
> 
> True, but there is always a point where you have to say, "This isn't
> working, we need to re-write it".  Coding by cutting and pasting
> existing code is not a great idea.
> 
> 
>>I bet the thing to do is to spend some time as one of the
>>elves who make bugzilla.kernel.org work smoothly despite
>>the software; then figure out what incremental tweak you
>>can make to the software to make the elves' and users' lives
>>better.
> 
> 
> I am not prepared to start editing the existing Bugzilla code - there
> is nothing about it that I think it right at the moment.  I could
> write a better bug tracking database in a couple of weeks if I wanted
> to.

Ok, have you looked at other bug tracking programs?  Can you find 
something you can build on?  Take a look at this list of issue tracking 
software:
http://www.a-a-p.org/tools_tracking.html
It has a lot of possibilities... different combinations of features and 
implementation languages.

Could you perhaps expound a bit on your statement "there is nothing 
about [bugzilla] that I think [is] right at the moment"?

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

