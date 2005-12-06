Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVLFTHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVLFTHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVLFTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:07:13 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42195 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030193AbVLFTHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:07:11 -0500
Date: Tue, 6 Dec 2005 20:07:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, rostedt@goodmis.org, johnstul@us.ibm.com
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Message-ID: <20051206190713.GA8363@elte.hu>
References: <20051206000126.589223000@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512061628050.1610@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512061628050.1610@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> Hi Thomas,
> 
> On Tue, 6 Dec 2005 tglx@linutronix.de wrote:
> 
> Before I get into a detailed review, I have to asked a question I 
> already asked earlier: are even interested in a discussion about this?

we are certainly interested in a technical discussion!

> I would prefer if we could work together on this, but this requires 
> some communication. I know I'm sometimes a little hard to understand, 
> but you don't even try to ask if something is unclear or to explain 
> the details from your perspective.

you think the reason is that you are "sometimes a little hard to 
understand". Which, as i guess it implies, comes from your superior 
intellectual state of mind, and i am really thankful for your efforts 
trying to educate us mere mortals.

but do you honestly believe that this is the only possible reason? How 
about "your message often gets lost because you often offend people and 
thus do not respect their work" as a possibility? How about "hence it 
has not been much fun to work with you" as a further explanation?

to be able to comprehend what kind of mood we might be in when reading 
your emails these days, how about this little snippet from you, from the 
second email you wrote in the ktimers threads:

"First off, I can understand that you're rather upset with what I wrote,
 unfortunately you got overly defensive, so could you please next time
 not reply immediately and first sleep over it, an overly emotional
 reply is funny to read but not exactly useful."

 http://marc.theaimsgroup.com/?l=linux-kernel&m=112743074308613&w=2

and to tell you my personal perspective, the insults coming from you in 
our direction have not appeared to have stopped since. I am being dead 
serious here, and i'd love nothing else if you stopped doing what you 
are doing and if i didnt have to write such mails and if things got more 
constructive in the end. Insults like the following sentence in this 
very email:

> [...] So Thomas, please get over yourself and start talking.

let me be frank, and show you my initial reply that came to my mind when 
reading the above sentence: "who the f*ck do you think you are to talk 
to _anyone_ like that?". Now i'm usually polite and wont reply like 
that, but one thing is sure: no technical thought was triggered by your 
sentence and no eternal joy filled my mind aching to reply to your 
questions. Suggestion: if you want communication and cooperation, then 
be cooperative to begin with. We are doing Linux kernel programming for 
the fun of it, and the style of discussions matters just as much as the 
style of code.

i'm not sure what eternal sin we've committed to have deserved the 
sometimes hidden, sometimes less hidden trash-talk you've been 
practicing ever since we announced ktimers.

in any case, from me you'll definitely get a reply to every positive or 
constructive question you ask in this thread, but you wont get many 
replies to mails that also include high-horse insults, question or 
statements. Frankly, i dont have that much time to burn, we've been 
through one ktimer flamewar already and it wasnt overly productive :)

	Ingo
