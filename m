Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVJCV5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJCV5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbVJCV5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:57:14 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:27796 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S932438AbVJCV5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:57:13 -0400
Date: Mon, 3 Oct 2005 22:55:00 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003215500.GA6722@apogee.jonmasters.org>
References: <20051002204703.GG6290@lkcl.net> <35fb2e590510030720t416dc210xc4e4eb11b3972822@mail.gmail.com> <20051003202239.GE8548@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003202239.GE8548@lkcl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 09:22:39PM +0100, Luke Kenneth Casson Leighton wrote:

> On Mon, Oct 03, 2005 at 03:20:46PM +0100, Jon Masters wrote:

> > On 10/2/05, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:

>  hellooo jon.
> 
> > Haven't seen you since I believe you gave a somewhat interesting talk
> > on FUSE at an OxLUG a year or more back. 
> 
>  good grief, that long ago?

Indeed. Time flies.

> > I don't think anyone here is
> > selectively deaf, but some might just ignore you for such comments :-)
>  
>  pardon?  oh - yes, i'm counting on it, for a good signal/noise
>  ratio.  sad to recount, the strategy ain't workin too well,
>  oh well.  i've received about 10 hate mails so far, i _must_
>  be doing _something_ right.

I hate to sound like "one of them" but nothing you've said is revolutionary -
really it's not - but you're saying it as if you just dreamed it up today and
/that's/ what got people annoyed. One of those pseudo-intellectual Starbucks
moments, if you will.

> > > the basic premise: 90 nanometres is basically... well...
> > > price/performance-wise, it's hit a brick wall at about 2.5Ghz, and
> > > both intel and amd know it: they just haven't told anyone.
> > 
> > But you /know/ this because you're a microprocessor designer as well
> > as a contributor to the FUSE project?
>  
>  i have been speaking on a regular basis with someone who
>  has been dealing for nearly twenty years now with processor
>  designs (from a business perspective, for assessing high-tech
>  companies for investment and recruitment purposes).  i have
>  been fortunate enough to have the benefit of their experience
>  in assessing the viability of chip designs.

In other words, no. I'm not a processor designer either (very few people
are) but I do have a lot of experience with Xilinx FPGAs and I'll add
something of relevence to the end of this message. The point really is
that some people here know a great deal more than you do about this (and
I'm not saying I'm one of them), they're going to rightfully feel a
little annoyed if you start preeching to the choir.

> > The main issue (as I understand it)
> > is that SMT/SMP is taking off for many applications and manufacturers
> > want to cater for them while reducing heat output - so they care less
> > about MHz than about potential real world performance.
> 
>  pipelining.  pipelining.  latency between blocks.

Would you mind learning to use capitali[sz]ation in your mail? It's
really not very easy to read what you write. Was the above intended to
be an actual sentence (in which case I can't see any clauses in the
above) or just random words which - if said together - will summon some
mystical power upon us?

> > > so, what's the solution?
> > 
> > > well.... it's to back to parallel processing techniques, of course.
> > 
> > Yes. Wow! Of course! Whoda thunk it? I mean, parallel processing!
> > Let's get that right into the kern...oh wait, didn't Alan and a bunch
> > of others already do that years ago? Then again, we might have missed
> > all of the stuff which went into 2.2, 2.4 and then 2.6?
> 
>  jon, jon *sigh* :)

My point was that some very much more cleaver people have worked on this
for a very long time already. Alan did a lot of cool stuff in the
beginning, what Ingo does now just scares me, etc.

> i meant _hardware_ parallel processing

Old hat. It's been worked on for over a decade and some of it is working
out now in the form of concept processors that mix FPGAs with CPUs.

> - i wasn't referring to anything led or initiated by the linux kernel,
> but instead to the simple conclusion that if hardware is running out of
> steam in uniprocessor (monster-pipelined; awful-prediction;
>  let's-put-five-separately-designed-algorithms-for-divide-into-the-chip-and-take-the-answer-of-the-first-unit-that-replies sort of design)
>  then chip designers are forced to parallelise.

So simple in fact that it's already done in most common hardware. Why
else would we have any offload chips at all?

Please help me to understand the value of your original message. I've
read it a few times, but it continues to allude me.

Jon.
