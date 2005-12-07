Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVLGDFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVLGDFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVLGDFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:05:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23197 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750926AbVLGDF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:05:29 -0500
Date: Wed, 7 Dec 2005 04:05:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
In-Reply-To: <20051206190713.GA8363@elte.hu>
Message-ID: <Pine.LNX.4.61.0512062030570.1610@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512061628050.1610@scrub.home> <20051206190713.GA8363@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Dec 2005, Ingo Molnar wrote:

> you think the reason is that you are "sometimes a little hard to
> understand". Which, as i guess it implies, comes from your superior
> intellectual state of mind, and i am really thankful for your efforts
> trying to educate us mere mortals.

I can assure you my "superior intellectual state of mind" is not much 
different from many other kernel hackers. I have at times strong opinions, 
but who here hasn't?

> to be able to comprehend what kind of mood we might be in when reading 
> your emails these days, how about this little snippet from you, from the 
> second email you wrote in the ktimers threads:
> 
> "First off, I can understand that you're rather upset with what I wrote,
>  unfortunately you got overly defensive, so could you please next time
>  not reply immediately and first sleep over it, an overly emotional
>  reply is funny to read but not exactly useful."

Here we probably get to the root of the problem: we got off on the wrong 
foot. 
In my first email I hadn't much good to say about the initial 
announcement, but at any time it was meant technical. Anyone who compares 
the first and the following announcement will notice the big improvement. 
Unfortunately Thomas seemed to have to taken it rather personal (although 
it never was meant that way) and I never got past this first impression 
and ever since I can't get him back to a normal conversation.

> Insults like the following sentence in this very email:
> 
> > [...] So Thomas, please get over yourself and start talking.

I must say it's completely beyond me how this could be "insulting". This 
is my desperate attempt at getting any conversation started. If Thomas 
isn't talking to me at all, I can't resolve any issue he might have with 
me. Instead he's just moping around, pissed at me and simply ignores me, 
which makes a conversation over this channel nearly impossible.

> let me be frank, and show you my initial reply that came to my mind when 
> reading the above sentence: "who the f*ck do you think you are to talk 
> to _anyone_ like that?". Now i'm usually polite and wont reply like 
> that,...

You may haven't said it openly like that, but this hostility was still 
noticable. You disagreed with me on minor issues and used the smallest 
mistake to simply lecture me. From my point the attitude you showed 
towards me is not much different from what you're accusing me of here.
I'm not saying that I'm innocent about this, but any "insult" was never 
intentional and I tried my best to correct any issues after we got off on 
the wrong foot, but I obviously failed at that, I simply never got past 
the initial impression.

> in any case, from me you'll definitely get a reply to every positive or 
> constructive question you ask in this thread, but you wont get many 
> replies to mails that also include high-horse insults, question or 
> statements.

Let's take the ptimer patches, I got _zero_ direct responses to it and 
it's difficult for me to understand how this could be taken as "high-horse 
insult". As I obviously failed to make my criticism understandable before, 
I produced these patches to provide a technical base for a discussion of 
how this functionality could be merged in the hopes of "Patches wont be 
ignored, i can assure you", unfortunately they were.
Ingo, you might now start to understand my frustration. One positive 
effect at least is that finally some movement got into this mess and you 
managed to produce a simplified version of the timer. OTOH since I never 
got a reply to these patches does that mean they were neither positive nor 
constructive?

bye, Roman
