Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314655AbSD1B1Q>; Sat, 27 Apr 2002 21:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314656AbSD1B1P>; Sat, 27 Apr 2002 21:27:15 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:61361 "EHLO
	pimout2-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S314655AbSD1B1P>; Sat, 27 Apr 2002 21:27:15 -0400
Subject: Re: The tainted message
From: Richard Thrapp <rthrapp@sbcglobal.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <31444.1019953661@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 20:27:07 -0500
Message-Id: <1019957228.8818.109.camel@wizard>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 19:27, Keith Owens wrote:
> On Sat, 27 Apr 2002 16:20:03 +0100 (BST), 
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >How about
> >
> >Warning: The module you have loaded (%s) does not seem to have an open
> >	 source license. Please send any kernel problem reports to the
> >	 author of this module, or duplicate them from a boot without
> >	 ever loading this module before reporting them to the community
> >	 or your Linux vendor
> 
> I'm going for the current message followed by "See <URL> for more
> information".  <URL> defaults to http://www.tux.org/lkml/#s1-18,
> vendors who want to point to their policy text can override the URL
> when they build modutils.

Why did you tell me to ask here and go with what Alan said if you
weren't going to listen to the discussion?  Alan's message corrects all
of the problems we found.  Several people agreed on the basic form.  If
you weren't going to go with the agreed upon result, why did you have me
ask here?  You just wasted a lot of our time.  You should have just told
me earlier that you weren't going to correct it -- I would have accepted
the decision.

I get sick and tired of maintainers who solicit opinions and then refuse
to listen to the answers they get back, even when people who know what
they are doing agree... even when the majority agrees.  I've seen it
happen many times.  I know it's the maintainer's choice in the end, but
don't ask for community opinions unless you're going to listen to them. 
It's insulting and infuriating.

As for your correction, people aren't going to look up an URL in
general.  It's too inconvenient.  Many of them will probably just forget
about the message and report bugs to the wrong place anyway.

I provide a module, not a distribution.  I've found that people want to
choose their distribution, even sometimes in embedded space, so I let
them (and I have no interest in providing a distribution anyway).  I
cannot control what modutils they run.  But I get bug reports back on
the module due to the tainted message.

At the very least, -please- change the verb tense of the message to be
correct.  That will at least eliminate the "module doesn't load" bug
reports (I hope).

-- Richard Thrapp


