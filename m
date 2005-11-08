Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbVKHWI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVKHWI5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVKHWI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:08:56 -0500
Received: from mail.gmx.de ([213.165.64.20]:38277 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030377AbVKHWI4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:08:56 -0500
X-Authenticated: #428038
Date: Tue, 8 Nov 2005 23:08:53 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3D video card recommendations
Message-ID: <20051108220853.GA26615@merlin.emma.line.org>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <1131112605.14381.34.camel@localhost.localdomain> <1131349343.2858.11.camel@laptopd505.fenrus.org> <1131367371.14381.91.camel@localhost.localdomain> <20051107152009.GA20807@shuttle.vanvergehaald.nl> <1131377496.2858.21.camel@laptopd505.fenrus.org> <1131384906.14381.108.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131384906.14381.108.camel@localhost.localdomain>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Nov 2005, Steven Rostedt wrote:

> On Mon, 2005-11-07 at 16:31 +0100, Arjan van de Ven wrote:

> > well despite your post; the Windows people are a lot better at keeping
> > old drivers working (win 9x to a NT based kernel was obviously a huge
> > change though). In linux you can use an old driver maybe for 6 months if
> > you're lucky.. in windows 6 years is no exception. So the problem is a
> > lot bigger in linux for the owner of such a card than it is in windows.
> 
> Only if the Linux driver is closed source.  Otherwise, the driver should
> be upgraded with the kernel.  Most all open source hardware drivers are
> already included in the kernel, and maintained as long as there's
> someone that has the device that can maintain it.

I'd rather not count the drivers that have dropped out of open source
operating systems due to bit rot. If there is no maintainer, the
hardware will become useless sooner or later. With Linux's rapidly
changing "moving target" 2.6.X I'd call it sooner rather than later.

OSS drivers are good iff there is a maintainer - IOW: to the user, the
maintainer makes the difference, not the driver being open source.

-- 
Matthias Andree
