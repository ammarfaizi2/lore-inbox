Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSHMR1O>; Tue, 13 Aug 2002 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318254AbSHMR1M>; Tue, 13 Aug 2002 13:27:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4115 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318968AbSHMRZw>; Tue, 13 Aug 2002 13:25:52 -0400
Date: Tue, 13 Aug 2002 14:29:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rob Landley <landley@trommello.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44.0208130942130.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Linus Torvalds wrote:

> Also, a license is a two-way street. I do not think it is morally right
> to change an _existing_ license for any other reason than the fact that
> it has some technical legal problem.

Agreed, but we might be running into one of these.

> I don't like patents. But I absolutely _hate_ people who play politics
> with other peoples code. Be up-front, not sneaky after-the-fact.

Suppose somebody sends you a patch which implements a nice
algorithm that just happens to be patented by that same
somebody.  You don't know about the patent.

You integrate the patch into the kernel and distribute it,
one year later you get sued by the original contributor of
that patch because you distribute code that is patented by
that person.

Not having some protection in the license could open you
up to sneaky after-the-fact problems.

Having a license that explicitly states that people who
contribute and use Linux shouldn't sue you over it might
prevent some problems.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

