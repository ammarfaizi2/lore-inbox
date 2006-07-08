Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWGHX5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWGHX5t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWGHX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 19:57:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43154 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932345AbWGHX5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 19:57:49 -0400
Date: Sun, 9 Jul 2006 01:57:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Olivier Galibert <galibert@pobox.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708235721.GH2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com> <1152353698.2555.11.camel@coyote.rexursive.com> <1152355318.3120.26.camel@laptopd505.fenrus.org> <20060708164312.GA36499@dspnet.fr.eu.org> <1152380363.27368.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152380363.27368.12.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Very often, choice is good. but for something this fundamental, it is
> > > not. We also don't have 2 scsi layers for example.
> > 
> > We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we
> 
> (We've had effectively two SCSI layers before now btw when we've done
> transitions from old_eh to new_eh)
> 
> > have had 2 pcmcia subsystems and 2 usb subsystems.  At one point, it's
> > the only way to find out what will work out.  Suspend2 and uswsusp
> > have very different fundamental designs, and it's quite unclear at
> > that point which one is the right one.
> 
> I'd like to see this cleared up at OLS/Kernel summit. 

Unless something very wrong happens, I'll be at OLS/Kernel summit.

...it is going to be interesting week. I expect apparmor flamefest,
and this... Any idea where to buy cheap asbestos underwear? :-)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
