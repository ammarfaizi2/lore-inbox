Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSHWW7u>; Fri, 23 Aug 2002 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSHWW7u>; Fri, 23 Aug 2002 18:59:50 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:22533 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313190AbSHWW7u>; Fri, 23 Aug 2002 18:59:50 -0400
Date: Sat, 24 Aug 2002 01:03:10 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Greg Banks <gnb@alphalink.com.au>, Peter Samuelson <peter@cadcamlab.org>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <Pine.LNX.4.44.0208231015540.22497-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208240059560.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Aug 2002, Kai Germaschewski wrote:

> > I believe fixing the existing rules within the existing syntax is an exercise
> > worth doing, and that the results will carry across to whatever extended syntax/
> > new language/new parsers/whatever will be the long-term solution.
>
> Let me just second this. This doesn't mean to try random changes hoping
> that in the end the result is something sensible. But there are many cases
> which are obviously bugs or deficiences, and fixes / cleanups there are
> definitely a good idea as a first step.

Let me mention (again), that we are talking about two different problems
here. On the hand bugs in the rulebase can be fixed with either syntax. On
the other hand major cleanups/extensions are better done with only a
single parser.

bye, Roman

