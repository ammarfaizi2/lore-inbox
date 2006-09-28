Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965249AbWI1DRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965249AbWI1DRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 23:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965248AbWI1DRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 23:17:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965249AbWI1DRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 23:17:02 -0400
Date: Wed, 27 Sep 2006 20:15:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Patrick McFarland <diablod3@gmail.com>
cc: Chase Venters <chase.venters@clientec.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <d577e5690609271754u395e56ffr1601fddd6d4639a3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>  <1159342569.2653.30.camel@sipan.sipan.org>
  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr> 
 <1159359540.11049.347.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>  <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
  <20060927225815.GB7469@thunk.org>  <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
  <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
 <d577e5690609271754u395e56ffr1601fddd6d4639a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Patrick McFarland wrote:
> On Wednesday 27 September 2006 20:18, Linus Torvalds wrote:
> > I think a lot of people may be confused because what they see is
> > 
> >  (a) Something that has been brewing for a _loong_ time. There has been
> >      the FSF position, and there has been the open source position, and
> >      the two have been very clearly separated.
> 
> But whats wrong with that? The FSF is a "project" (or really, a group
> of projects, because some FSF projects don't agree with the FSF
> position either), it isn't them official voice of the community.

Right, I'm not saying that there is anything wrong with having two 
positions.

In many ways, I'm saying the opposite. I'm saying that we should _expect_ 
people to have different opinions. Everybody has their own opinion anyway, 
and expecting people not have different opinions (especially programmers, 
who are a rather opinionated lot in the first place) is just not 
realistic.

There's absolutely nothing wrong with having a very wide consensus among a 
very varied developer base. In fact, I think that's _great_.

And the reason I'm speaking out against the GPLv3 is that it is trying to 
"sort the chaff from the wheat". The FSF is apparently not happy with a 
wide community appeal - they want _their_ standpoint to be the one that 
matters.

I have all through the "discussion" tried to explain that the great thing 
about the GPLv2 is that it allows all these people with totally different 
ideals to come together. It doesn't have to be "perfect" for any 
particular group - it's very perfection comes not from it's language, but 
the very fact that it's _acceptable_ to a very wide group.

When the FSF tries to "narrow it down", they kill the whole point of it. 
The license suddenly is not a thing to get around and enjoy, it's become a 
weapon to be used to attack the enemy.

Here in the US, the only watchable TV news program is "The Daily Show" 
with Jon Stewart. One of his fairly recurring themes is about how US 
politics is destroyed by all these passionate and vocal extremists, and he 
asks whether there can ever be a really passionate moderate. "Can you be 
passionate about the middle road?"

Dammit, I want to be a "Passionate Moderate". I'm passionate about just 
people being able to work together on the same license, without this 
extremism.

So here's my _real_ cry for freedom:

 "It's _ok_ to be commercial and do it just for money. And yes, you can 
  even have a FSF badge, and carry Stallmans manifesto around everywhere 
  you go. And yes, we accept people who like cryptography, and we accept 
  people who aren't our friends. You don't have to believe exactly like we 
  believe!"

And for fifteen years, the GPLv2 has been a great umbrella for that. 

The FSF is throwing that away, because they don't _want_ to work with 
people who don't share their ideals. 

> >      At the same time, both camps have been trying to be somewhat polite,
> >      as long as the fact that the split does clearly exist doesn't
> >      actually _matter_.
> 
> I agree. It doesn't matter because everyone is free to use whatever
> version they want of the GPL. Of course, people do also recognize that
> the GPL2 vs GPL3 argument is just a more subtle version of whats been
> going on for years with BSD vs GPL.

That's part of what really gets my goat. I spent too much time arguing 
with crazy BSD people who tried to tell me that _their_ license was "true 
freedom". The FSF shills echo those old BSD cries closely - even though 
they are on the exact opposite side of the spectrum on the "freedom" part. 

I hated BSD people who just couldn't shut up about their complaining about 
my choice of license back then (the good old BSD/MIT vs GPL flamewars). 

> >                      In fact, most programmers _still_ probably
> >      don't care. A lot of people use a license not because they "chose"
> >      it, but because they work on a project where somebody else chose the
> >      license for them originally.
> 
> Programmers don't care because we aren't lawyers. I mean, few things
> are stated so simply, but lets face it, law is boring to quite a few
> geeks, and the intersection between geeks who code and geeks who law
> is very small.

I think a _lot_ of programmers care very deeply indeed about the licenses. 
I certainly do. I wouldn't want to be a lawyer, but I care about how my 
code gets used.

That said, I don't care how everybody _elses_ code gets used, which is 
apparently one of the differences between me and rms.

> > Not really. It wasn't even news. The kernel has had the "v2 only" thing
> > explicitly for more than half a decade, and I have personally tried to
> > make it very clear that even before that, it never had anything else (ie
> > it very much _had_ a specific license version, just by including the damn
> > thing, and the kernel has _never_ had the "v2 or any later" language).
> 
> Wasn't that just to prevent the FSF from going evil and juping all your code?

Well, initially it wasn't even a conscious "I don't trust the FSF" thing. 
But when I chose the GPL (v2, back then) I chose _that_ license. There was 
absolutely no need for me to say "or later". If the GPLv2 ever really 
turns out to be a bad license, we can re-license _then_.

Yes, it would be really really painful, but I think the "or later" wording 
is worse. How can you _ever_ sign anything sight unseen? That's just 
stupid, and that's totally regardless of any worries about the FSF.

Later, when I did start having doubts about the FSF, I just made it even 
more clear, since some people wondered.

> The only problem is that, alternatively, the FOSS movement was so
> strong because of RMS's kool-aid everyone drank. The community has
> teeth, and this is in partly because of the actions of the FSF. We
> defend ourselves when we need to.
> 
> Its just that, at least with the Tivo case, that the defense went a tad too
> far.

I think the FSF has always alienated as many (or more) people as they 
befriended, but maybe that's just me. I was looking for old newsgroup 
threads about this earlier in the week, and noticed somebody in the BSD 
camp saying that I was using the GPL, but that I wasn't as radical as rms. 
And iirc, that was from 1993, when Linux was virtually unknown.

So I think that not being too extreme is a _good_ thing. It's how you can 
get more people involved.

So everybody - join the "Passionate Moderate" movement, even if you're not 
in the US. We're not passionate about any of the issues, we are just 
_really_ fed up with extreme opinions! And we're not afraid to say so!

[ The really sad part is: that was only _somewhat_ in jest. Dammit, 
  sometimes I think we really need that party! ]

			Linus
