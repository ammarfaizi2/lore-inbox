Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWHQJTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWHQJTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHQJTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:19:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53229 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932382AbWHQJTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:19:05 -0400
Date: Thu, 17 Aug 2006 11:18:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>
Subject: Re: Merging libata PATA support into the base kernel
Message-ID: <20060817091842.GC17899@elf.ucw.cz>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex> <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E3E1E6.9090908@PicturesInMotion.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I agree.  Moreover, the disk-related resume-from-ram problems are the hardest
> > ones (the graphics may be handled from the user land to a reasonable extent).
> >
> > Actually, I'm looking for someone who'd agree to be Cced on bug reports where
> > we suspect the problem may be related to IDE/PATA/SATA . ;-)
> >
> > Greetings,
> > Rafael
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >   
> Well it seems I am one of those users who is bit by the resume bug. I
> was wondering why no developer has replied to my
> bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
> users have. Id try to fix it myself but Ive never done kernel

Time to learn?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
