Return-Path: <linux-kernel-owner+w=401wt.eu-S1750974AbXAHVRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXAHVRM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbXAHVRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:17:12 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60782 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750974AbXAHVRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:17:11 -0500
Date: Mon, 8 Jan 2007 17:14:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070108161425.GA2208@elf.ucw.cz>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain> <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr> <20070107223055.1dc7de54@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107223055.1dc7de54@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2007-01-07 22:30:55, Alan wrote:
> > >The kernel maintainers/help/config pretty consistently use UTF8
> > 
> > I've seen a lot of places that don't do so. Want a patch?
> 
> I think that would be a good idea - and add it to the coding/docs specs
> that documentation is UTF-8. Code should IMHO say 7bit though.

Yes, yes, please.

I have been flamed when someone tried to do 8bit patch, and I was
trying to NAK it...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
