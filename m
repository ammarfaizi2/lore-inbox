Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265221AbUD3TMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUD3TMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUD3TMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:12:39 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:1040 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265221AbUD3TMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:12:34 -0400
Message-ID: <4092A642.2050801@techsource.com>
Date: Fri, 30 Apr 2004 15:17:22 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Michael Poole <mdpoole@troilus.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com> <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com> <40927F6F.9020907@canalmusic.com> <765C53A8-9AC6-11D8-B83D-000A95BCAC26@linuxant.com> <87zn8tmkd6.fsf@sanosuke.troilus.org> <A8F43910-9AD6-11D8-B83D-000A95BCAC26@linuxant.com>
In-Reply-To: <A8F43910-9AD6-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:
> 
> On Apr 30, 2004, at 1:44 PM, Michael Poole wrote:
> 
>> Marc Boucher writes:
>>
>>> I am not threatening anyone, only reminding folks that making
>>> unsubstantiated public allegations that unfairly damage a person or
>>> company's reputation is wrong and generally illegal.
>>>
>>> Marc
>>
>>
>> I do not think the allegations are unsubstantiated or unfair;
> 
> 
> A number of allegations were clearly wrong. Some posters have even 
> admitted or even criticized these factually incorrect accusations. 
> Instead of wasting more time/energy arguing or litigating, we hope that 
> this debate will now end peacefully and have helped to clarify and 
> resolve problems.

No one here really wants to sue you.  Those people who have been arguing 
with you are doing so because they take you seriously.  If they thought 
you were a moron and you were worthless, they would be ignoring you.

I think I speak for many here when I say that we respect your business 
and your right to write the sort of software that you're doing.  We 
would just like you make sure that you follow the law, for your own sake 
as well as ours.

> 
>> on the
>> contrary, people have identified with specificity what is offensive
>> and probably illegal.  Might I remind you of 17 USC 1201(b)(1):
> 
> 
> It is extremely ironic that the free software community who was so 
> strongly opposed to the DMCA and considering it so evil now invokes it 
> in such a far fetched manner (Alan Cox was probably cynical about this 
> but you don't seem to be). It is also far from clear whether tainting 
> and the MODULE_LICENSE() macro are a "technological measure that 
> effectively protects" anything.

Well, I agree.  Only one person invoked the DMCA.  Others, such as 
myself, invoked Copyright law, which more people agree with.

Look at it this way:  You broke more than one law.

> 
> Again, our workaround is purely cosmetic, its side-effect on tainting 
> totally unintentional, we are sorry that it has caused so much concern 
> and we will be fixing it in good faith (even if it is a broken concept), 
> while hoping that the underlying problems will be correctly resolved in 
> future kernels/modutils.

Stop telling us how unintentional it was!

> 
> On Apr 30, 2004, at 2:01 PM, Timothy Miller wrote:
> 
>>
>> Nope.  The real objection was misleading people about the license of 
>> the module.  That part was clearly wrong.
> 
> 
> We did not mislead people. Our license terms are clear and openly stated 
> in many places.
> You could perhaps argue that we "mislead" a string comparison to fix a 
> usability problem, but this kind of technique is very common today, 
> especially under Linux where numerous interfaces are simulated. 

I am not aware that it's a common practice.  Can you provide an example?

However, if someone else it doing it, they are wrong too, and that does 
not give you license to imitate them.

 > Would
> you pretend that things like Wine are wrong and misleading when making 
> windows software believe that it runs under the real thing?

WINE is not a problem for Linux, because it cannot corrupt the kernel 
(it's all in user space).

WINE is not a problem for Windows programs, because making a Windows 
program misbehave in user space does not make the rest of the system 
unstable, and it does not violate any laws.  Also, people using WINE are 
aware that they are using WINE and are therefore not surprised when 
something doesn't work right.  WINE isn't trying to hide from anyone the 
fact that it's a compatibility layer.

