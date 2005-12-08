Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVLHJ0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVLHJ0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbVLHJ0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:26:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:11715 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750958AbVLHJ0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:26:38 -0500
Date: Thu, 8 Dec 2005 10:26:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051208092629.GC21696@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home> <20051206190713.GA8363@elte.hu> <Pine.LNX.4.61.0512062030570.1610@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512062030570.1610@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,NO_OBLIGATION autolearn=no SpamAssassin version=3.0.3
	0.6 NO_OBLIGATION          BODY: There is no obligation
	-0.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > to be able to comprehend what kind of mood we might be in when reading 
> > your emails these days, how about this little snippet from you, from the 
> > second email you wrote in the ktimers threads:
> > 
> > "First off, I can understand that you're rather upset with what I wrote,
> >  unfortunately you got overly defensive, so could you please next time
> >  not reply immediately and first sleep over it, an overly emotional
> >  reply is funny to read but not exactly useful."
> 
> Here we probably get to the root of the problem: we got off on the 
> wrong foot.

yes.

> In my first email I hadn't much good to say about the initial 
> announcement, but at any time it was meant technical. Anyone who 
> compares the first and the following announcement will notice the big 
> improvement.  Unfortunately Thomas seemed to have to taken it rather 
> personal (although it never was meant that way) [...]

what you did was in essence to piss on his code, concepts and 
description. [oh, i wrote roughly half of ktimers, so you pissed on my 
code too ;-) ]

Here are a few snippets from you that show that most of the negative 
messaging from you was directed against the text Thomas wrote (or 
against Thomas), not against the code:

" How you get to these conclusions is still rather unclear, I don't even
  really know what the problem is from just reading the pretext. "

" What is seriously missing here is the big picture. "

" This no answer at all, you only repeat what you already said above. "

" The main problem with your text is that you jump from one topic to the
  next, making it impossible to create a coherent picture from it. "

" You don't think that having that much timers in first place is little 
  insane (especially if these are kernel timers)? "

" Later it becomes clear that you want high resolution timers, what 
  doesn't become clear is why it's such an essential feature that 
  everyone has to pay the price for it (this does not only include 
  changes in runtime behaviour, but also the proposed API changes). "

" It's nice that you're sure of it, but as long don't provide the means 
  to verify them, they are just assertions. "

note that these were pretty much out of the blue sky, and they pretty 
much set the stage. Given that Thomas is a volunteer too, he does not 
have to bear with what he senses as arbitrary abuse.

> [...] and I never got past this first impression and ever since I 
> can't get him back to a normal conversation.

maybe because your 'get him back to a normal conversation' attempt used 
precisely the same somewhat dismissive and somewhat derogatory tone and 
type of language that your initial mails were using? Past experience is 
extrapolated to the future, so even small negative messages get easily 
blown up, and the "cycle of violence" never stops, because nobody breaks 
the loop.

> > Insults like the following sentence in this very email:
> > 
> > > [...] So Thomas, please get over yourself and start talking.
> 
> I must say it's completely beyond me how this could be "insulting".  

maybe it is insulting because the "get over yourself" implicitly 
suggests that the fault is with Thomas?

Let me give you a few alternatives, that might have had a completely 
different effect and which do not contain any implicit insults:

 "So Thomas, I know we got on to the wrong footing, but lets start
  talking again."

or:

 "So Thomas, I know we had a couple of nasty exchanges in the past, but 
  lets bury the hatchet and try again. I apologize if I offended you in 
  any way in the past."

just try it, really. Even if it's a bold faced lie ;)

> This is my desperate attempt at getting any conversation started. If 
> Thomas isn't talking to me at all, I can't resolve any issue he might 
> have with me. [...]

Thomas wrote you 11 replies in 2.5 months, and some of those were 
extremely detailed. That's a far cry from not talking at all. He did try 
hard, he did get involved in a flamewar with you, which wasnt overly 
productive. But he is a volunteer, he has no obligation to waste time on 
flamewars.

> > let me be frank, and show you my initial reply that came to my mind when 
> > reading the above sentence: "who the f*ck do you think you are to talk 
> > to _anyone_ like that?". Now i'm usually polite and wont reply like 
> > that,...
> 
> You may haven't said it openly like that, but this hostility was still 
> noticable. You disagreed with me on minor issues and used the smallest 
> mistake to simply lecture me. From my point the attitude you showed 
> towards me is not much different from what you're accusing me of here.

yes, i definitely was not nice in a couple of mails, and i'd like to 
apologize for it.

> I'm not saying that I'm innocent about this, but any "insult" was 
> never intentional and I tried my best to correct any issues after we 
> got off on the wrong foot, but I obviously failed at that, I simply 
> never got past the initial impression.

ok, apology taken :)

> > in any case, from me you'll definitely get a reply to every positive or 
> > constructive question you ask in this thread, but you wont get many 
> > replies to mails that also include high-horse insults, question or 
> > statements.
> 
> Let's take the ptimer patches, I got _zero_ direct responses to it 
> [...]

well, direct communication with you has proven to be very unproductive a 
number of times, so what would have been the point? But we did mention 
lots of technical points in our subsequent mails, referring to your 
ptimers queue a number of times. We even adopted the ktime.h 
simplification idea and credited you for it.

also, what did you expect? Basically you came out with a patch-queue
based on ktimers, but you did not send any changes against the ktimers
patch itself, which made it very hard to map the real finegrained
changes you did to ktimers. You provided a writeup of differences, but
they did not fully cover the full scope of changes, relative to ktimers.
You based your queue on a weeks old version of ktimers, which also
raises the possibility that you were working on this for some time, in
private, for whatever reason. (Again, this is not a complaint - we are
happy you are communicating via code - whatever form that code is in.)

> [...] and it's difficult for me to understand how this could be taken 
> as "high-horse insult". As I obviously failed to make my criticism 
> understandable before, I produced these patches to provide a technical 
> base for a discussion of how this functionality could be merged in the 
> hopes of "Patches wont be ignored, i can assure you", unfortunately 
> they were.

they were not ignored - we mentioned the ptimer changes in our 
subsequent announcements, and we Cc:-ed you to those annoucements so 
that you get it first-hand.

	Ingo
