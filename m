Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVDMOyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDMOyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDMOyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:54:33 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:64726 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261357AbVDMOyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:54:00 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Marco Colombo <marco@esi.it>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050412184545.GB18557@pegasos>
References: <1113235942.11475.547.camel@frodo.esi>
	 <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi>
	 <20050411210754.GA11759@pegasos>
	 <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
	 <20050412054002.GB22393@pegasos>
	 <Pine.LNX.4.61.0504121458010.31686@Megathlon.ESI>
	 <20050412184545.GB18557@pegasos>
Content-Type: text/plain
Organization: ESI srl
Date: Wed, 13 Apr 2005 16:53:56 +0200
Message-Id: <1113404036.12421.83.camel@frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 20:45 +0200, Sven Luther wrote:
> On Tue, Apr 12, 2005 at 06:14:17PM +0200, Marco Colombo wrote:
> > No one will ever do that. If you are distributing the software I released
> > under GPL, be sure I _will_ sue you if you break the licence. What do you
> > want from me? A promise I won't sue you if you don't? That is implicit
> > in the existance of the licence.
> > 
> > Are you implying debian will stop distributing _any_ software unless
> > the all the copyright holders of GPL software "explicitly say" they
> > won't sue you?
> 
> Well, we won't distribute binaries placed under the GPL, definitively not. And
> if there is a dubious case, we ask for clarification of the author.

Your choice, of course.

[...] 
> > This is different. They are not giving the source at all. The licence
> > for those object files _has_ to be different. _They_ want it to be
> > different.
> 
> Sure, but in this case, the binary firmware blob is also a binary without
> sources. If they really did write said firmware directly as it is, then they
> should say so, but this is contrary to everyone's expectation, and a dangerous
> precedent to set.

You should realize that any author can publish his work in the form he
likes. He's not bound to "everyone's expectation". I see no danger in
that.

> > >So, really, i doubt any manufacturer distributing non-free firmware would
> > >really have trouble in adding to their licence something like this :
> > >
> > > In addition, <manufacturer>, considers the firmware blob, identified as 
> > > <...>, as
> > > a non-derivative piece of work, and thus not covered by the GPL of the 
> > > rest
> > > of it. <manufacturer> gives permission to distribute said firmware blob as
> > > part of the linux kernel module driver for their hardware. The actual 
> > > syntax
> > > of the inclusion of the code is still covered by the GPL, as is the rest 
> > > of
> > > the driver code.
> > 
> > This is fine with me. It is the existance of legal threats versus 
> > debian I don't agree upon.
> 
> Notice that debian can't afford to be sued even if they are right, so ...

So what? This is not the point. You can be sued any time by any one,
even if you're right. If debian can't afford it, it can't afford
existance.

> > >>Yes, but it does not apply to our case here. There's no "all other
> > >>copyright holders". _You_ stated that the firmware is included by mere
> > >>aggregation, so there's no other holders involved. We're talking
> > >>about the firmware case. A is one or two well identified subjects.
> > >>And A wrote it is GPL'ed. Whether you agree or not, that's the licence
> > >>A chose. A placed the copyright notice.
> > >
> > >This is where i would need legal counsel, as to whether this means C or
> > >someone else may stop you from distributing unless you provide the source. 
> > >And
> > >the real problem is that A didn't state anything, so we are only working on
> > >the assumption that this may be the case, and A can change its mind later, 
> > >and
> > >the costs to defend ourselves in front of a judge, even if your
> > >interpretations are right, are enough prohibitive for debian not to 
> > >distribute
> > >said files.
> > 
> > A did put a GPL notice on it. He can't change his mind later.
> 
> Then he should give us the source.

No, why? GPL cannot place restrictions or obligations on the copyright
owner. Let's stop discussing it please, you can't buy me on this
either. I have my own interpretation of what a license it, and it seems
you don't agree with it: to me, it's one way: _you_, the licensee,
get some rights if you fulfill some conditions. Conditions are all
placed on you, none on the copyright holder. In particular, the
one about making source available is placed on distributors,
verbatim copies of the source for binary distribution of the work, or
full source of the modifications for modified versions of the work.
 
And anyway, this has nothing to do with with legal threats from the
copyright holder. My point being: he cannot sue you for not
distributing the source "as provided by him" if he failed to provide
them in the first place in a different from. That is, he has to give you
the source, if he is trying to force you distributing it.

> > >>The licence is a matter between A and D. A may sue D and D may (less
> > >>likely) sue A, if conditions are not met. I'm not sure at all GPL
> > >>is enforceable by D upon A. Let's assume it is, for sake of discussion,
> > >>anyway.
> > >
> > >Ah, but the licence is transitive, and if D may sue A, then C may also sue 
> > >D,
> > >since the GPL makes no distinction between who makes the distribution, 
> > >apart
> > >from the fact that A may relicence its code. But if he distributes it as 
> > >part
> > >of the GPL ...
> > 
> > Pardon me, I have no idea of what a "transitive" licence could be.
> > Sublicencing or relicencing is _explicitly_ not covered by GPL anyway.
> 
> You give away the source to someone, he has the same rights you had, except
> relicencing, this is what i meant by transitive.

GPL explicitly says that when you, a distributor, give the source to
someone, he receives a license, another "instance" of GPL so to say,
directly from the copyright holder and not from you. If your license
is GPL, then his license is GPL, too, and yes, he has the same rights
of you. But it's not you granting those rights to him, it's the
copyright holder.
 
> > Also I have no idea of what you mean "GPL makes no distinction between
> > who makes the distribution". GPL for sure places no restrictions on
> > how A can distribute his software. A needs no license for exercising
> 
> No, it gives A the choice to distribute its software under the GPL, or under
> another licence.

I think GPL "gives" nothing to A. A can do whatever he wants with his
software, GPL has no effect on A. It would be A granting rights to A.
Nonsense. A does not need to "release" the software under any license
to himself. A has full rights on it, already.

> > rights on the software. He is the _owner_ of rights. A cannot "break"
> > the GPL. A needs no GPL to distribute. Are you saying A may sue himself?
> 
> Yes, he can break the commonly accepted expectation of a GPLed software, which
> is what happens here. He is free to distribute the software under any other
> licence he sees fit, which is what i am asking here.

I'm sorry. We totally disagree on this. GPL is a license. The commonly
accepted expectation is that it places restrictions on the licensee,
in exchange of some rights. The copyright holder is no licensee.
He needs to comply to no conditions. He already has (and owns) full
rights. And anyway, he is the only one entitled the right of enforcing
those conditions or voiding the license. How could he enforce any
conditions on himself? How could he void a license to himself, given
that he needs no license at all?
Let's drop this, please, we're going nowhere.

> > >>>No. The source code is clearly the prefered form of modification, not 
> > >>>some
> > >>>random intermediate state A may be claiming is source.
> > >>
> > >>In this context, it is. Only A may sue D for not distributing the source.
> > >>Whatever D distributes, D has to make A happy. If A is happy with D
> > >>distributing `dd if=/dev/random count=1` as source, no one can stop D
> > >>from doing that. Keep in mind A is the copyright holder. He grants
> > >>rights to third parties. No one but A can remove them.
> > > 
> > >Yep, so if A was giving us an explicit right to distribute his sources,
> > >everyone would be happy, this not being the case, we have to take the
> > >hypothesis that A will sue us at a later time.
> > 
> > A placed it under GPL. If that is not "explicit right to distribute his
> > source", I'm not able to think of anything that could be it.
> 
> He is not distributing sources here, he is distributing binaries, my error.

Well, no. You are distributing the binary, after you compiled the 
kernel. The hexstring is the source, the binary aggregated to the
kernel image is the binary. The GPL notice is attached to the hexstring.

[...] 
> > So you seriously think this makes sense?
> > 
> > A: you have to distribute the source, or the licence will be void
> > D: i am, i'm distributing the source you gave me
> > A: that is not the source, i was lying about it
> > D: then give me the right source, and I'll distribute it
> > A: No. I refuse to give you the right source, but expect you to distribute
> >    it anyway, or i'll terminate the licence.
> 
> No, the licence auto-terminate and the software becomes undistributable.

Nothing "auto-terminates". A can ask the judge to order D to stop
distribution. If you seriously think that, in front of such claims by A,
any judge will rule of favor of A, well, there's no point in discussing.
D is not able to distribute the source "as provided" by A, if A is not
providing it. A cannot have such a condition enforced without providing
the source, in the first place.

The license terminates when A manages to convince the judge D is not
fulfilling a condition. I think no one would ever consider 
"i don't want to give you the right source, but you must distribute it
anyway" a valid argument.

> > >he could claim, as some did here, that obviously the fimrware was not 
> > >GPLed,
> > >but mere aggregation, and that he nowhere gave any right to distribute 
> > >them.
> > 
> > "mere aggregation" refers to an action taken by a distributor. _You_
> > as debian are distributing the firmware as merely aggregated to the
> > kernel, assuming your intrepretation is right. That has nothing to do
> > with .c files.
> 
> The fact remains that those firmware blob have no licence, and thus defacto
> fall under the GPL.

Precisely.

> > Moreover, the firmare in not in binary form, but is part of a C source
> > file.
> 
> It is in binary form. Disguised binary form maybe but still binary form.

Ah, but this is a claim A has to make in front of a judge, before the 
license of D can be terminated. "I gave him a source that is really
a disguised binary form, and not the real source. He's distributing
that 'source' as i provided it, but it's not the real one. I'm not
willing to give him the real one, but I'm requesting him to distribute
it.". Makes no sense. D: "I'm providing it as provided, which is the
requirement of GPL. Should I receive it in another form, I'd distribute
it in the new form."

> > I think you're going no where. A cannot put a licence statement on
> > the top of a .c file stating it's GPL'ed, and then say that some part
> > of it is not covered because it was "merely aggregated". It makes no
> > sense, and there's nothing in the GPL about mere aggregation of sources.
> 
> What i want is that A aknolwedges that he is not distributing the sources of
> the firmware, and thus cannot place the binary blob under the GPL but should
> chose another licence.

That would be fine. But it's a matter of having thing sorted out
correctly. 

> > >>>>That, in court? Is this really what you're afraid of?
> > >>>>The outcome is, very likely A will be forced to release the full source.
> > >>>>(and D forced to distribute it, but all D's we're talking of here are
> > >>>>very happy with the full disclosure scenario, aren't they?)
> > >>>
> > >>>Imagine A refusing to give away the source code, and D is ordered to 
> > >>>remove
> > >>>the incriminated code it is illegally distributing from all its servers,
> > >>>and
> > >>>recall all those thousands of CD and DVD isos containing the code it
> > >>>distributed, and being fined for each day it doesn't do so ?
> > >>
> > >>Sorry, this is nonsense. D is well willing to distribute the source.
> > >>In this case, he _is_ distributing what A publicly stated to be the 
> > >>source.
> > >
> > >Yep, apart from the fact that A never did publicly state such issue, but 
> > >just
> > >passed it under silence.
> > 
> > On the top of a .c file there's a nice copyright notice and licence 
> > statement,
> > isn't there? A placed it there. _You_ think it may be changed. But what
> > if A is fine with it?
> 
> Not in the tg3.c case, no.

Are you saying that the notice has been wrongly placed by the 
holders or by someone else? If they changed their mind, there's 
little they can do. If _someone else_ published the code and
put a wrong license notice on it, that's a different matter.
A _false_ notice is different from a _wrong_ legitimate one.
"Wrong" as in: they changed their mind at later time. 

> > >But the GPL states that we must be able to distribute the sources, clearly
> > >defines what said sources are, and states what happens if you can't 
> > >fullfill
> > >a clause of the GPL -> no right to distribute at all.
> > 
> > No. GPL says you must be _willing_ to distribute the sources, as received
> > by A. See, GPL covers the source. There's no way you can distribute
> > the software in binary/executable form, unless you get the source and
> > complile it. That's what you do here. You compile the hexstring, and
> > the firmware (in binary form) gets "aggregated" to the kernel binary.
> > If you distribute the result, you have to distribute the source _as
> > you received it_. That's all. If you do, you're fine.
> 
> And where did those hexstrings come from ? 

There's only one subject that can put such a question: the copyright
holder, since it's the only one that can request enforcement of a
GPL condition. "You provided it" it's enough an answer. It's a dead
end, the copyright holder can't go any further w/o providing the
real source.

I think we reached a dead end ourself.

For the debian case, I think:

- no one can sue debian, but the copyright holder, for breaking GPL
  in the act of distributing the firmware blob; debian received a GPL
  from the copyright holder when they got the program

- there's no way the copyright holder could sue debian for not
  distributing source (assuming debian is distributing the kernel
  tarball of course, which is not a problem), w/o providing something
  different they claim to be the "real" source.

As usual, IANAL.

.TM.
-- 
      ____/  ____/   /
     /      /       /                   Marco Colombo
    ___/  ___  /   /                  Technical Manager
   /          /   /                      ESI s.r.l.
 _____/ _____/  _/                      Colombo@ESI.it

