Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265722AbSKATLy>; Fri, 1 Nov 2002 14:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265723AbSKATLy>; Fri, 1 Nov 2002 14:11:54 -0500
Received: from otter.mbay.net ([206.55.237.2]:45071 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S265722AbSKATLt> convert rfc822-to-8bit;
	Fri, 1 Nov 2002 14:11:49 -0500
From: John Alvord <jalvo@mbay.net>
To: "Shane R. Stixrud" <shane@stixrud.org>
Cc: Patrick Finnegan <pat@purdueriots.com>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Date: Fri, 01 Nov 2002 11:18:03 -0800
Message-ID: <sek5sukqk3q4iqp5u80hgp6mb2tpq483m9@4ax.com>
References: <Pine.LNX.4.44.0211011108320.10880-100000@ibm-ps850.purdueriots.com> <Pine.LNX.4.44.0211010826260.31740-100000@tpn-fw1.processing.net>
In-Reply-To: <Pine.LNX.4.44.0211010826260.31740-100000@tpn-fw1.processing.net>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002 10:23:01 -0800 (PST), "Shane R. Stixrud"
<shane@stixrud.org> wrote:

>
>On Fri, 1 Nov 2002, Patrick Finnegan wrote:
>> 
>> I'm sorry it _is_ a public service.  Once tens of people started   
>> contributing to it, it became one.  This is like saying that the
>> Washington Monument belongs to the peole that maintain it, any building
>> belongs to the repair crews and janitors.  I'm not saying that Linus is
>> necessarily a janitor, but when you consider how much of the Linux kernel
>> that he didn't write, you may relize that it's not just his kernel.  It
>> also belongs to every single person that has written even a single
>> line of code in it.
>>
>
>The logic you seem to be missing is, the Washington Monument is a
>physical object.  Linus's source tree is a collection of "copied" parts 
>from other peoples source trees.  You obviously see his source copy 
>as special, more so then say my copy.  This is true _ONLY_ because 
>Linus's copy commands more respect then yours or mine.  
>If you think about it, the respect Linus's copy has is _PURELY_ 
>the result of his past _choices_ over how he maintains it.
>
>
>In effect you are saying: 
>
>Patrick: "Everyone trusts your source tree, I think LKCD 
>is SUPER DUPER important and should get the exposure and trust 
>that being in your tree commands." 
>
>Linus: "I think LKCD is a bad idea, until I am convinced otherwise I 
>will not merge it."  
>
>Patrick: "You are wrong, LKCD should be in your copy of the kernel source.
>It is your Job Linus, to add things to _your_ copy which others find 
>important, what you think is secondary."
>
>
>You cannot have it both ways, either Linus's tree is a dumping 
>grounds for all ideas (both good and bad) or it is a place for good 
>ideas (good defined by Linus) where people who trust Linus's judgment can 
>work from.
>
>In truth you can have it both ways.  Take Linus's existing copy, add the 
>features you think are important.  If your choices prove to be superior. 
>you can expect that people (over time) will begin to trust/respect your 
>copy more then Linus's.

This also explains why Linus said it was a vendor push situation. If
vendors pick it up, find it useful (as I am sure they will), and tell
Linus about that usage... LKCD will become part of the mainline tree.
I suspect for most vendors, it would be part of their extra cost
"server" package and the Linux/390 package... It clearly has the
potential to enhance service and buyers of server packages need it.

If along the way, significant numbers of "big users" like Purdue adopt
it, use it, and reflect back to L-K the diagnostic successes and fixes
which result, that could speed the decision. If Linus has a tough bug,
installs LKCD, sends the dump to a wizzard and gets a fix, that would
definitely speed the decision.

john alvord
