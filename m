Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVDTRVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVDTRVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVDTRTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:19:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61610 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261742AbVDTRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:18:30 -0400
Date: Wed, 20 Apr 2005 19:18:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
Message-ID: <20050420171806.GB3372@elf.ucw.cz>
References: <20050419175743.GA8339@beton.cybernet.src> <20050419182529.GT17865@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419182529.GT17865@csclub.uwaterloo.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have seen a device by CorAccess which apparently uses Linux and didn't find
> > anything that would suggest it complies to GPL, though I had access to the
> > complete shipping package. Does anyone know about known cause of violation by
> > this company or should I investigate further?
> 
> Well what is the case if you use unmodified GPL code, do you still have
> to provide sources to the end user if you give them binaries?  I would
> guess yes, but IANAL.
> 
> As far as I can tell their system is a geode GX1 so runs standard x86
> software.  Maybe they didn't have to modify any of the linux kernel to
> run what they needed.  Their applications are their business of course.
> It looks like they use QT as the gui toolkit, which I don't off hand
> know the current license conditions of.  Then there is the web browser
> and such, which has it's own license conditions.  Of course for all I
> know their user manual has an offer of sending a CD with the sources if
> you ask.  Does anyone actually have their product that could check for
> that?

QT is GPLed, IIRC. Not LGPL-ed, meaning you can't link it with
proprietary application without license from trolltech.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
