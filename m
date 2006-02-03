Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWBCVez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWBCVez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945990AbWBCVez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:34:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:21916 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1945988AbWBCVey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:34:54 -0500
Date: Fri, 3 Feb 2006 22:33:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-ID: <20060203213335.GA10531@elte.hu>
References: <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <1138891081.9861.4.camel@localhost.localdomain> <Pine.LNX.4.64.0602020814320.21884@g5.osdl.org> <43E23C79.8050606@drzeus.cx> <Pine.LNX.4.64.0602020937360.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602020937360.21884@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> wrote:

> It boils down to this: we wrote the software. That's the only part _I_ 
> care about, and perhaps (at least to me) more importantly, because 
> it's the only part we created, it's the only part that I feel we have 
> a moral right to control.

yes, that's how i feel too. Quid pro Quo. But we are in the minority.  
The majority of Linux users, and the vast majority of commercial Linux 
players doesnt give a rat's a** about giving back a Quid, as a fair 
compensation for our Quo.

(i dont see a problem with that by the way - i consider it a basic moral 
right to have different moral rules. The moment i'd require others to 
share exactly the same morals i'd become just another crusader. But i 
digress.)

what the others see is the black and white letter of the GPL [or just 
some free software they can download and install], not a moral situation 
with us, which they would have to understand and meet. They are and will 
increasingly try to give back as little as they can get away with - 
depending on their own moral rules. Some will also try to employ tactics 
that we see as "immoral", and they wont see it as immoral, under their 
own rules.

(one extreme example for a community with very strong moral rules is the 
Sicilian Mafia. They had (and still have) extremely strong inner rules, 
and everyone within a given family is loved and is being taken care of 
for a lifetime - in the positive sense of the word. Still the external 
effect on the rest of society is perverse and disastrous. But i digress 
again.)

so the only solution is to convert our moral rules to an objective set 
of rules, as accurately as possible. This in our society would be the 
(neutral) letter of the law, and a copyright license in particular.  

after that act of conversion we can only hope for the best that no 
detail important to us gets lost in the process. Our (your) initial 
approach to that was the GPLv2, and it was a pretty accurate (and lucky) 
first approximation.

what do we have today? We've got bin-only kernel modules, much of which 
are clearly immoral, they are clearly hurting us and still we do things 
to keep them going - e.g. the refusal to remove 8K stacks from the 
.config. We are increasingly getting into a situation where loopholes 
are found and utilized to give back as little as possible, upsetting the 
balance.

so i believe _something_ should be done to tip the balance, because the 
negative effects are already hurting us. I'd support the move to the 
GPLv3 only as a tool to move the balance back into a fairer situation, 
not as some new moral mechanism. The GPLv3 might be overboard for that, 
but still the situation does exist undeniably.

> I _literally_ feel that we do not - as software developers - have the 
> moral right to enforce our rules on hardware manufacturers. [...]

yes, and i do share your morals on that. OTOH i do think there are a 
few more aspects:

- most of the known violations of the Quid pro Quo comes from the space 
  of closed hardware that is pushing for DRM best. So there's some 
  itching in me to just make things more strict in the area that is 
  causing us the most problems.

- can they give us the source code for the modifications on Linux on a 
  DRM-ed medium that we cannot read on any open hardware? From a moral 
  POV they cannot, but can they do it legally? Could they argue in 5 
  years that SHD-DVD version 10 is a 'widely used' medium, and that they 
  met the letter of the GPLv2? If we never enforce that the source be 
  actually compilable and usable on real hardware, how can we suddenly 
  claim to have a right to run it on open hardware? We might create a
  legal waiver or estoppel situation if we dont enforce the usefulness 
  of the source code given back to us. Even cockroaches are surprisingly
  creative - after all there is a business entity on this planet that 
  thought it to be fair to produce source code in discovery by printing 
  it out to a ton of paper and then scanning it back in ;-) And they 
  even got away with it!

- we really grew up on the supposition that there is a fundamental 
  ability and right to tinker. Business entitities were simply not able 
  back then to restrict that, technologically. Today there are business 
  models that seem to be working just fine with closed hardware. Content 
  and programmability restrictions via crytography are more and more
  practical, and the day will come when the Xbox will be truly 
  cryptographically safe and totally closed.

  NOTE: i do know that the elimination of tinkering is bad for society 
  down the road - so in theory we should win in the long run. But 
  society might not care! Maybe only 1 civilization out of a 100 get 
  past this stage of development - the rest destroy themselves and 
  create a burned out shell of a planet with some proto-civilization
  and no resources left. Nature is really, really cruel.

  Do we have the moral right to restrict (in the worst case, eliminate) 
  our children's ability to tinker _at all_? Doesnt our software become 
  totally useless if the possibility to tinker gets eliminated? Only 
  1-5% of all people have the brain structure and desire to tinker (and 
  to think creatively), so if it were up for a vote today we'd lose in 
  the polls, badly ...

  Dont you think we have the moral obligation to support all the 
  "infrastructure" that gave us this ideal paradise of tinkering with 
  Linux in the first place? Dont you sense we (programmers, tinkerers) 
  are a minority that could _easily_ be opressed by society at large, 
  without them even noticing? Supporting fact: society is heading 
  towards a nice big greenhouse effect right now, with 99% of the 
  scientists crying bloody murder already - and basically nothing is
  done. Crushing these 'geek dudes' which would indeed result in lost 
  productivity a few decades down the line, but right now it wouldnt 
  even be a blip on the policy radar i'm afraid, as long as it results 
  in blockbuster movies getting on to the TV screen faster, and as long 
  as it results in a 5% cheaper HD-DVD player ...

  Thinking about those issues and current trends, i'm really getting an 
  urge to grab some bigger protective gear, like the GPLv3!

	Ingo
