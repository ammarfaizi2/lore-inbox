Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTJaQGM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 11:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTJaQGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 11:06:12 -0500
Received: from panda.sul.com.br ([200.219.150.4]:45064 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S263387AbTJaQGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 11:06:10 -0500
Date: Fri, 31 Oct 2003 14:00:46 -0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031160046.GA15319@cathedrallabs.org>
References: <20031030141519.GA10700@redhat.com> <9cfd6cdla4o.fsf@rogue.ncsl.nist.gov> <20031031152453.F4556@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031031152453.F4556@flint.arm.linux.org.uk>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And APM suspend seems to have broken in -test8.  Does it work for
> > anyone?
> 
> Doesn't work for me.
works for me. it isn't rock solid as in 2.4 but most times it resumes
without problems even using dma on ide controller (in 2.4 i should
disable dma before suspend and couldn't enable it later).

> Now, taking off my "open source co-operative hat" and placing my
> "reality" hat on, I'd suggest that anyone who finds that APM doesn't
> work to consider it a dead loss - It's an obsolete technology, and
> therefore no one is interested in it anymore.  I've reported the
> problem multiple times here and there's been very little, if any,
> reaction, so this seems to back that up.
i guess it isn't exactly the problem. maybe there's no _developers_ with
time and skills to work on it. i would do it if i have enough skills.
when stock 2.6 comes out we'll have a lot of people complaining
about APM because there a lot of notebooks out there that still needs
it. including mine.

--
aris

