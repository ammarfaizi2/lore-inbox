Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286349AbRLJSds>; Mon, 10 Dec 2001 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286353AbRLJSdi>; Mon, 10 Dec 2001 13:33:38 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42764 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S286349AbRLJSd0>; Mon, 10 Dec 2001 13:33:26 -0500
Date: Mon, 10 Dec 2001 19:32:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Clemens <john@deater.net>
Cc: Cory Bell <cory.bell@usa.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011210193232.C24549@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011209131332.A37@toy.ucw.cz> <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0112101016140.15280-100000@pianoman.cluster.toy>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Hey, this gross hack fixed USB on HP OmniBook xe3. Good! (Perhaps you
> > > > know what interrupt is right for maestro3, also on omnibook? ;-).
> 
> I've updated my bios on my Pavilion N5430 and guess what is shows on
> the bios boot screen (if you disable the bios splash screen)... Omnibook
> XE3.  They are one in the same, at least model number wise.  weird,
> considering there are no AMD omnibooks..

Get /tmp/xe3-tech-code-11-2-01.pdf document from hp. It looks like
they are ;-).
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
