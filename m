Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWIYIPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWIYIPU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWIYIPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:15:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27860 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750709AbWIYIPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:15:19 -0400
Date: Mon, 25 Sep 2006 10:15:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060925081517.GB2107@elf.ucw.cz>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060922230928.GB22830@kroah.com> <20060923045610.GM541@1wt.eu> <20060923232150.GK5566@stusta.de> <20060924101753.GB4813@ucw.cz> <20060925012322.GE4547@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925012322.GE4547@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > And my rules are:
> > > - patch must be in Linus' tree
> > > - I'm asking the patch authors and maintainers of the affected subsystem
> > >   whether the patch is OK for 2.6.16
> > 
> > I thought stable rules were longer than this... including 'patch must
> > be < 100 lines' and 'must be bugfix for serious bug'. Changing rules
> > for -stable series in the middle of it seems like a bad idea...
> 
> I stated what I'd do with 2.6.16 before I took over maintainance.

I do not remember you stating that
Documentation/stable_kernel_rules.txt is obsolete, and that you'll
have your own version. Heh, I'm not sure greg understood that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
