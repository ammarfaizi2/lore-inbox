Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265038AbSKAOrh>; Fri, 1 Nov 2002 09:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265040AbSKAOrh>; Fri, 1 Nov 2002 09:47:37 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:58884 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S265038AbSKAOrf>; Fri, 1 Nov 2002 09:47:35 -0500
Date: Fri, 1 Nov 2002 09:55:38 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org
Subject: Re: What's left over.
In-Reply-To: <aptgsu$b29$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.44.0211010931090.10880-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Henning P. Schmiedehausen wrote:

> Patrick Finnegan <pat@purdueriots.com> writes:
>
> >Because I'm not a vendor, and I want it.
>
> You don't have a vendor, but roll your own kernels? Tough, so you're
> are a "vendor". Surprise, surprise.
>
> Replace "vendor" with "people who roll up and distribute kernels". So
> one vendor (Linus) refuses to integrate LKCD. Tough. Use another

I'm confused, you just said (1) I'm a vendor and then (2) Linus is my
vendor.  And besides, we don't distribute the kernels - we install them on
our own machines, and say 'done'.  The lack of distribution (at least IMO)
should make us not be a vendor.

> one. Think USP here. Think diversity. Think competition. Maybe "that
> vendor" (Linus) will catch up one day. Maybe not. Maybe "competition"
> is not on his agenda. So what?

This isn't about competition.  It's about integrating a core useful
feature that has been shown to be emperically useful by every other person
who writes an OS kernel.

> Get SuSE. They will integrate everything and their grand mother in
> their kernels.

That's not really an option at the moment.  We have a disto vendor
(RedHat) and were dissatisfied with its kernels so we are trying to use
*the*official* kernel (Linus's kernel).

> Gee, most people seem to think that "vendor" means "big evil
> corporation in Redmont, WA".

No, vendor == people who sold or gave us the softare.  Right now, Linus is
acting like he's a big evil corporation that won't add the change no
matter what we say:

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> On Thu, 31 Oct 2002, Matt D. Robinson wrote:
> >
> > Sure, but why should they have to?  What technical reason is there
> > for not including it, Linus?
<snipped reasons that are imho incorrect>
> To me this says "LKCD is stupid". Which means that I'm not going to
> apply it

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> Don't bother to ask me to merge the thing, that only makes me get even
> more fed up with the whole discussion.

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> And imnsho, debugging the kernel on a source level is the way to do it.
>
> Which is why it's not going to be me who merges it.

On Fri, 1 Nov 2002, Linus Torvalds wrote:

> You got to hear my comment now, several times: convince somebody _else_.
<snip>
> What's so hard to understand about the "vendor-driven" thing, and why do
> people continue to argue about it?

You know, considering the volume of people on this list that have been
saying "I want it, Linus, please integrated it"  and:

On Thu, 31 Oct 2002, Matt D. Robinson wrote:

> I hate Linus' ego, I hate this whole damn discussion, and I find
> it very irritating that I have to go through this process after
> many people have created, enhanced and used LKCD for three years,
> and this is where we're at.
>
> To spend the last month and a half finalizing things for Linus,
> sending this to him on multiple occasions, asking for his comments
> and inclusion, asking for his feedback (as well as others), and
> not hearing _one damn word_ from Linus all that time, and for him
> to wait until now to just say "LKCD is stupid" is insulting.

You know, pissing off core developers of projects that have been shown to
be (1) desired (2) potentially useful in Linux, even as an aid to other
Linux subsystem developers and (3) emperically show to be useful for other
Free *nixes such as the BSDs, is not what I would be doing as a project
maintainer.  Of course, I'm not Linus...

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif








