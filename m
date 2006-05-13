Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWEMTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWEMTGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWEMTGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 15:06:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57273 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964782AbWEMTGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 15:06:39 -0400
Date: Sat, 13 May 2006 21:05:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       trenn@suse.de, thoenig@suse.de, stable@kernel.org
Subject: Re: [stable] Re: [patch] smbus unhiding kills thermal management
Message-ID: <20060513190551.GB31347@elf.ucw.cz>
References: <20060512095343.GA28375@elf.ucw.cz> <44645FC2.80500@gmx.net> <20060512102004.GD28232@elf.ucw.cz> <Pine.LNX.4.61.0605121248540.9918@yvahk01.tjqt.qr> <20060512151524.GB22871@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512151524.GB22871@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> 
> > >> This is probably also -stable material.
> > >
> > >Yes, I'd like to see it go into -stable. (But IIRC stable rules were
> > >"mainline first").
> > 
> > That rule was already broken IIRC.
> 
> For non-security issues?  The rule is, "accepted by mainline".  So has
> the maintainer accepted this yet or not?

Andrew took it to the -mm tree. That's as close to "accepted by
maintainer" as it gets, I'd say.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
