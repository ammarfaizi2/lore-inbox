Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318966AbSHMRnN>; Tue, 13 Aug 2002 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHMRnM>; Tue, 13 Aug 2002 13:43:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5048 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318966AbSHMRlt>;
	Tue, 13 Aug 2002 13:41:49 -0400
Date: Tue, 13 Aug 2002 13:45:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rob Landley <landley@trommello.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <Pine.LNX.4.44L.0208131425500.23404-100000@imladris.surriel.com>
Message-ID: <Pine.GSO.4.21.0208131339110.1689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Aug 2002, Rik van Riel wrote:

> Suppose somebody sends you a patch which implements a nice
> algorithm that just happens to be patented by that same
> somebody.  You don't know about the patent.
> 
> You integrate the patch into the kernel and distribute it,
> one year later you get sued by the original contributor of
> that patch because you distribute code that is patented by
> that person.
> 
> Not having some protection in the license could open you
> up to sneaky after-the-fact problems.

Accepting non-trivial patches from malicious source means running code
from malicious source on your boxen.  In kernel mode.  And in that case
patents are the least of your troubles...

