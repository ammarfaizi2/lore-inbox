Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWAZSqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWAZSqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWAZSqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:46:00 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:46030 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751366AbWAZSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:45:45 -0500
Message-ID: <43D8FEF2.3080502@wolfmountaingroup.com>
Date: Thu, 26 Jan 2006 09:55:14 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
Cc: Filip Brcic <brcha@users.sourceforge.net>, Paul Jakma <paul@clubi.ie>,
       Linus Torvalds <torvalds@osdl.org>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <Pine.LNX.4.64.0601261757320.3920@sheen.jakma.org> <200601261925.49433.brcha@users.sourceforge.net> <Pine.LNX.4.64.0601261233150.17225@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0601261233150.17225@turbotaz.ourhouse>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:

> On Thu, 26 Jan 2006, Filip Brcic wrote:
>
>> ???? Thursday 26 January 2006 18:59, Paul Jakma ?? ???????(??):
>>
>>> On Wed, 25 Jan 2006, Linus Torvalds wrote:
>>>
>>>> In other words: the _default_ license strategy is always just the
>>>> particular version of the GPL that accompanies a project. If you
>>>> want to license a program under _any_ later version of the GPL, you
>>>> have to state so explicitly. Linux never did.
>>>
>>>
>>> That's not what section 9 seems to say. The default is "any version
>>> you like".
>>
>>
>> That's right, but
>>
>> Also note that the only valid version of the GPL as far as the kernel
>> is concerned is _this_ particular version of the license (ie v2, not
>> v2.2 or v3.x or whatever), unless explicitly otherwise stated.
>>
>> Linux specifies version GPLv2 and only v2. Therefore, for Linux the 
>> GPLv2 is
>> the default.
>>
>
> Well, my understanding is that this clause wasn't always in COPYING. 
> If not for section 9 of the GPL, then the default would have always 
> been GPLv2 only.
>
> But since this clause was added after some time, one could argue that 
> some code in Linux, even lacking a specific "or any later version" 
> boilerplate, could be licensed under GPLv1, GPLv2, GPLv3, etc.
>
> However, as I stated before -- since this clause is now present, the 
> hairball going to GPLv3 would be copyright holders that submitted code 
> under the GPLv2 Only heading. Since Linus added this clause, and has 
> no doubt joined in many others submitting code since it was added, 
> portions of the kernel *are* GPLv2 Only; hence, it would be 
> impractical to legally migrate to GPLv3.
>
> I'll save from weighing in on whether or not GPLv3 is a good idea -- 
> this is just my evaluation of the facts I see before us.
>
> Cheers,
> Chase

Linus is posturing. I can go back to numerous previous versions when he 
and stallman were "buddy buddy" and the language was open
and said "any later version". Well, here's the gotcha. Any version 
released before Linus said this is GPL 2, 3 or later. As of today, all new
versions are GPLv2. That's how the law works. So 2.6.15 forward is GPLv2 
only. Linus cannot re-release previous Linux versions after he
already posted this NOTICE in COPYING, which he did and left the 
language pen like this. So it's up to the recevier of the code whether
its GPLv2 or GPLv3 or whatever, but those releases which appeared with 
COPYING stating this language are whatever GPL license you
want.

Jeff


