Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVBGOM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVBGOM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVBGOM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:12:28 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:51647 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261424AbVBGOMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:12:15 -0500
Date: Mon, 7 Feb 2005 15:09:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Message-ID: <20050207140937.GA8040@elf.ucw.cz>
References: <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <1107485504.5727.35.camel@desktop.cunninghams> <9e4733910502032318460f2c0c@mail.gmail.com> <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com> <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <1107782696.8575.72.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107782696.8575.72.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Some systems (intel notably) appear to expect you to use the bios
> > save/restore video state not re-POST.
> 
> This works well in many cases, but there are some machines that freeze
> if you attempt to make a VBE state save call. Sadly, I don't have any
> access to an affected machine, so it's a bit awkward working out what
> the problem is.

Where do I find code to do VBE save state? I might get you some
testing...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
