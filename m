Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSHMRAB>; Tue, 13 Aug 2002 13:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSHMRAA>; Tue, 13 Aug 2002 13:00:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7945 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318218AbSHMQ74>; Tue, 13 Aug 2002 12:59:56 -0400
Date: Tue, 13 Aug 2002 09:51:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@trommello.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Phillips <phillips@arcor.de>,
       Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208131636.g7DGaUZ265560@pimout1-ext.prodigy.net>
Message-ID: <Pine.LNX.4.44.0208130942130.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Rob Landley wrote:
>
> Last time I really looked into all this, Stallman was trying to do an 
> enormous new GPL 3.0, addressing application service providers.  That seems 
> to have fallen though (as has the ASP business model), but the patent issue 
> remains unresolved.

At least one problem is exactly the politics played by the FSF, which
means that a lot of people (not just me), do not trust such new versions
of the GPL. Especially since the last time this happened, it all happened
in dark back-rooms, and I got to hear about it not off any of the lists,
but because I had an insider snitch on it.

I lost all respect I had for the FSF due to its sneakiness.

The kernel explicitly states that it is under the _one_ particular version 
of the "GPL v2" that is included with the kernel. Exactly because I do not 
want to have politics dragged into the picture by an external party (and 
I'm anal enough that I made sure that "version 2" cannot be misconstrued 
to include "version 2.1".

Also, a license is a two-way street. I do not think it is morally right to 
change an _existing_ license for any other reason than the fact that it 
has some technical legal problem. I intensely dislike the fact that many 
people seem to want to extend the current GPL as a way to take advantage 
of people who used the old GPL and agreed with _that_ - but not 
necessarily the new one.

As a result, every time this comes up, I ask for any potential new
"patent-GPL" to be a _new_ license, and not try to feed off existing
works. Please dopn't make it "GPL". Make it the GPPL for "General Public
Patent License" or something. And let people buy into it on its own
merits, not on some "the FSF decided unilaterally to make this decision
for us".

I don't like patents. But I absolutely _hate_ people who play politics 
with other peoples code. Be up-front, not sneaky after-the-fact.

		Linus

