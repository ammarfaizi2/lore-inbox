Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSA3A0f>; Tue, 29 Jan 2002 19:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287518AbSA3A0L>; Tue, 29 Jan 2002 19:26:11 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:54157 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S287493AbSA3AXN>;
	Tue, 29 Jan 2002 19:23:13 -0500
Date: Tue, 29 Jan 2002 19:23:03 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129192303.A14739@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201292332.g0TNWwU21215@snark.thyrsus.com> <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 03:50:43PM -0800, Linus Torvalds wrote:
> > Ah.  So being listed in the maintainers list doesn't mean someone is actually
> > a maintainer it makes sense to forward patches to?
> 
> Sure it does.
> 
> It just doesn't mean that they should send stuff to _me_.
> 
> Did you not understand my point about scalability?  I can work with a
> limited number of people, and those people can work with _their_ limited
> number of people etc etc.
> 
> The MAINTAINERS file is _not_ a list of people I work with on a daily
> basis. In fact, I don't necessarily even recognize the names of all those
> people.

I understand that the sort of careful hierarchy that drives this
process is, by nature, an informal thing.  But it would still be nice
if _suggestions_ on how it worked were written down somewhere.  When
you've got patches that don't have a clear relevant maintainer, it
would be nice to have something more specific than "post to
linux-kernel and pray someone picks it up" to run with!

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
