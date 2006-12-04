Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935845AbWLDKuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935845AbWLDKuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935868AbWLDKuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:50:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14258 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S935845AbWLDKuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:50:39 -0500
Date: Mon, 4 Dec 2006 11:50:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Christer Weinigel <christer@weinigel.se>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061204105031.GA10976@elf.ucw.cz>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <m3ac2nt7o8.fsf@zoo.weinigel.se> <87041D5C-ECA9-494A-8210-93646FDEA943@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87041D5C-ECA9-494A-8210-93646FDEA943@mac.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-12-03 16:40:04, Kyle Moffett wrote:
> On Nov 19, 2006, at 17:04:23, Christer Weinigel wrote:
> >With suspend-to-disk I can remove the battery (to put in a fresh  
> >battery when traveling), try doing that with suspend-to-ram.
> 
> My PowerBook can do this with suspend-to-ram too; it has an internal  
> capacitor or battery of some sort which charges in a few minutes and  
> holds enough power to keep the RAM alive for around a minute while I  
> swap batteries.

Well.. OTOH your powerbook is probably the _only_ machine that can do
that :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
