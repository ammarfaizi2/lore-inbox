Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbUJ1JVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbUJ1JVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbUJ1JVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:21:25 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:34510 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S262845AbUJ1JUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:20:51 -0400
Message-ID: <4180B9E9.3070801@andrew.cmu.edu>
Date: Thu, 28 Oct 2004 05:20:41 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roman Zippel <zippel@linux-m68k.org>, Andrea Arcangeli <andrea@novell.com>,
       Larry McVoy <lm@work.bitmover.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 27 Oct 2004, Roman Zippel wrote:
>  
>
>>Linus, what disturbs me here is that I don't see that you don't even try 
>>to acknowledge that the bk license might be part of problem
>>    
>>
>
>Why?
>
>What's the problem? You don't like it, you don't use it. It's literally 
>that simple.
>
>This is the same thing as with the GPL. I absolutely _detest_ people who 
>whine about the GPL - and there are more GPL haters out there than BK 
>haters. It's _their_ problem. 
>
>EXACT SAME THING. Nobody has the right to whine about another persons
>choice of license. You have a choice: use it or don't. Complaining about
>the license to the author isn't part of it.
>  
>

Actually it's not that simple.  With the free BK license it's not _your_ 
choice that affects validity; It's the choice of any person at your 
company deciding for everyone else.  So if one OSDL employee uses the 
free BK licence, *nobody else* at OSDL can work on an SCM, even at home 
in their spare time.  Technically, if any one of the other 10,000 people 
at my university work on an SCM, I can't use it either since they pay 
me.  I try to bury my head in the sand and think that they aren't.  In 
reality however, I can't vouch for what the other 9,999 people are 
doing.  Here's the relevant sentence in the license:

3(d) Notwithstanding  any  other  terms  in  this  License, this License 
is not available to You if You and/or your employer develop,  produce, 
sell, and/or resell a product which contains substantially similar 
capabilities of  the  BitKeeper Software, or, in the reasonable opinion 
of BitMover, competes with the BitKeeper Software.

IOW: "Not available to You if your employer develops anything 
substantially similar."

At least 90% of the whining/hate comes from this single clause in the 
license.  We know from the past that Larry won't budge on it, and that 
is of course his right.  However it is not true to say that this is like 
the GPL, or any MSFT license even.  None of them go that far in 
regulating what *other* people can do, especially what they can do at 
home, away from work.  My uni just opened a branch campus in Qatar;  If 
a student earns $10 to add some feature to SVN, it affects whether I can 
use BK for free at home on an open source project.  The alternative is 
paying a $2,600 per year seat license.

Imagine if in 1991, DOS/Windows cost $2,600 a year, unless you promised 
that neither you nor your employer would work on an operating system.  
That would cause a lot of argument, with pragmatic people trying to use 
the system for ordinary development of non-OSes, and others screaming 
about the "corrupt principles" and pushing alternatives, even if they 
suck in a features comparison.  Why is anyone surprised that this is 
happening now with BK?

BK is by far the best SCM I have ever used, and the only one that 
supports distributed development both sanely and robustly.  But frankly, 
it has a clause in its license that will generate arguments without end, 
ones which will *not* go away with time.

Larry, if anything is wrong in my analysis of the meaning of clause 3c, 
I would love to stand corrected.  Preferably that would take the form of 
an updated license.  I believe the analysis to be consistent with the 
wording of the clause; Several of my colleagues also analyzed the 
license and came to the exact same conclusions.

Jim Bruce
(Sorry for being OT.  Having said my only point on this topic, which 
I've held since the BK thing began, I will return to only reading these 
threads, after this one.  I welcome off-list discussions and/or flames too.)
