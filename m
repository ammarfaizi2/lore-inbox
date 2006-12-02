Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936565AbWLBS7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936565AbWLBS7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936566AbWLBS7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:59:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29591 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S936565AbWLBS7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:59:08 -0500
Date: Sat, 2 Dec 2006 19:58:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Acer smart battery (was Re: [RFC] Include ACPI DSDT from INITRD patch into mainline)
Message-ID: <20061202185854.GA3992@elf.ucw.cz>
References: <1164998179.5257.953.camel@gullible> <200612012301.20086.arekm@maven.pl> <20061202125004.GA4773@ucw.cz> <200612021834.59840.arekm@maven.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612021834.59840.arekm@maven.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-12-02 18:34:59, Arkadiusz Miskiewicz wrote:
> On Saturday 02 December 2006 13:50, Pavel Machek wrote:
> 
> > > Acer notebook users here dump DSDT from their own machine, fix it and
> > > then load via initrd. No legal problems. (... and without that even
> > > battery can't be monitored on sych notebooks)
> >
> > Merge smart battery support, instead of hacking DSDT. It is about time
> > linux started supporting smart batteries, and yes they are documented.
> Are you talking about this?
> https://sourceforge.net/forum/forum.php?forum_id=604605

Yes.

> It's seem to be already merged and I didn't even know about that
>feature.

Aha, I did not know that. Anyway, it should mean
no-longer-patching-DSDT.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
