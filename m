Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267722AbUHJUig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267722AbUHJUig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUHJUhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:37:02 -0400
Received: from gprs214-95.eurotel.cz ([160.218.214.95]:32129 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267724AbUHJUga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:36:30 -0400
Date: Tue, 10 Aug 2004 22:36:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Patrick Mochel <mochel@digitalimplant.org>, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810203612.GS28113@elf.ucw.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net> <20040810101308.GE9034@atrey.karlin.mff.cuni.cz> <200408101136.38387.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101136.38387.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Well, "no DMA" needs to be part of definition, too, because some
> > > > devices (USB) do DMA only if they have nothing to do.
> 
> I think that should read "even if they have ...", not "only if ...".

Yes, sorry.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
