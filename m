Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286273AbRL0PQU>; Thu, 27 Dec 2001 10:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286269AbRL0PQK>; Thu, 27 Dec 2001 10:16:10 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:45186 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S283777AbRL0PP6>; Thu, 27 Dec 2001 10:15:58 -0500
Date: Thu, 27 Dec 2001 16:15:51 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help editorial policy
Message-ID: <20011227151551.GB13004@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20011224094211.A15930@zapff.research.canon.com.au> <Pine.LNX.4.33.0112240713050.552-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112240713050.552-100000@mikeg.weiden.de>
User-Agent: Mutt/1.3.24i
X-Operating-System: vega Linux 2.4.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 07:25:44AM +0100, Mike Galbraith wrote:
> > Well, what we have is KB, which people _think_ they understand, but do not.
> > And KiB, which is ugly but well defined, albeit less known (at present).
> >
> > | Also, the kB vs KiB mess is so ambiguous and complex that
> > | it virtually guarantees that the _writers_ of documentation
> > | will get it wrong occasionally and only confuse the readers
> > | more.
> >
> > KiB is not ambiguous. KB demonstrably is.
> > And therefore KB is NOT useful for communication, _especially_ technical
> > communication.
> 
> Grep around in your RFC directory, and apply your argument.  The KiB
> definition will _create_ ambiguity in technical communication which
> did not exist before.

Agreed. I think almost technical guys assumed that 'KB' (or kB, or kb, or
something ;-) IS 1024 bytes. Know even they starting to loose their
belief about old one, and that new and 'strange' 'KiB'. Imho '1000 bytes =
1 kbytes' was only used by some tricky hardware vendors to trick their
costumers (they could show bigger values ...). But even my sister knows
that when someone's speaking about computers, 'kilo' means 1024, not 1000.

It's like when we declared that direction of electrical current is from
positive to negative. Yes, we CAN change it now, because we know that it's
not the right direction of electrons in real.

So, if the 'technical world' already assumed (imho) that 'kilo' is 1024
in computer technology then we shouldn't change it now ...

- Gabor
