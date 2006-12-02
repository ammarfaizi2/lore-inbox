Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163077AbWLBQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163077AbWLBQiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 11:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163074AbWLBQiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 11:38:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55825 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1163077AbWLBQiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 11:38:18 -0500
Date: Sat, 2 Dec 2006 12:50:05 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc.karlin.mff.cuni.cz>
Subject: Acer smart battery (was Re: [RFC] Include ACPI DSDT from INITRD patch into mainline)
Message-ID: <20061202125004.GA4773@ucw.cz>
References: <1164998179.5257.953.camel@gullible> <1165006694.5257.968.camel@gullible> <20061201215551.66b6eb60@localhost.localdomain> <200612012301.20086.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612012301.20086.arekm@maven.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Does that change the fact it is ugly ?
> > >
> > > No, but it does beg the question "how else can it be done"?
> >
> > Agreed.
> 
> So how else can it be done?
> 
> > > Distros need a way for users to add a fixed DSDT without recompiling
> > > their own kernels.
> >
> > Legal rights to do so aside, do they ? 
> 
> Acer notebook users here dump DSDT from their own machine, fix it and then 
> load via initrd. No legal problems. (... and without that even battery can't 
> be monitored on sych notebooks)

Merge smart battery support, instead of hacking DSDT. It is about time
linux started supporting smart batteries, and yes they are documented.

-- 
Thanks for all the (sleeping) penguins.
