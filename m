Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVBGOXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVBGOXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBGOXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:23:10 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:8101 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261427AbVBGOWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:22:46 -0500
Date: Mon, 7 Feb 2005 15:22:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger@gmx.at>,
       acpi-devel@lists.sourceforge.net,
       Ondrej Zary <linux@rainbow-software.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Message-ID: <20050207142219.GC8040@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4204B3C1.80706@rainbow-software.org> <9e473391050205074769e4f10@mail.gmail.com> <200502051748.43547.stefandoesinger@gmx.at> <9e47339105020509382adbbf39@mail.gmail.com> <420740F1.5050609@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420740F1.5050609@hist.no>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The problem with the radeon reset code is that there are many, many
> >variations of the radeon chips, including different steppings of the
> >same part. The ROM is matched to the paticular bugs of the chip. From
> >what I know ATI doesn't even have a universal radeon reset program.
> > 
> >
> Maybe they could provide such a program, if asked?
> Basically, a chip detect and a switch statement containing all
> the bios reset sequences they have.
> 
> They may want to protect "trade secrets" about innovative
> 3D-pipelines and such.  But the bios reset is probably not that
> high-end, so perhaps they could provide source code for it?

Try asking them, then ;-)....

Asked the right way, they might even tell you. I believe right way is
"I'd like to buy 10000 cards, but I need suspend-to-RAM to work".

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
