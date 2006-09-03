Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752092AbWICGeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbWICGeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 02:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWICGeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 02:34:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752092AbWICGeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 02:34:14 -0400
Date: Sun, 3 Sep 2006 08:34:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel/stop_machine.c: whose code is it?
Message-ID: <20060903063359.GA20890@elf.ucw.cz>
References: <20060831123241.GB3923@elf.ucw.cz> <Pine.LNX.4.58.0608311510120.511@twin.jikos.cz> <1157249168.19149.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157249168.19149.2.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Would kernel/stop_machine.c author please step up?
> > 
> > IMHO it's Rusty Russell (added to CC).
> 
> Yep.  Not sure the obsession with copyright on every trivial piece of
> code is healthy, but if it keeps you happy (I had to look back: this
> code was extracted from the module.c code in 2005).

I'd say it is definitely unhealthy, but knowing whose area of
expertise particular file is is sometimes helpful.

Thanks!
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
VGER BF report: U 0.500026
