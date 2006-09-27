Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWI0JCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWI0JCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWI0JCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:02:45 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6852 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751001AbWI0JCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:02:44 -0400
Date: Wed, 27 Sep 2006 11:02:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@stusta.de>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927090237.GB24857@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <200609270131.46686.rjw@sisk.pl> <20060926233903.GK4547@stusta.de> <200609270712.34082.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609270712.34082.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I fully agree. One of the largest issues I'm regularly dealing with is
> > > > people reporting problems with drivers.
> > > 
> > > Well, can we please have these reports forwarded to LKML or placed
> > > in the bugzilla?
> > 
> > The main question is:
> > 
> > Who will track these bugs, debug them (who is e.g. responsible for 
> > kernel Bugzilla #6035?) and repeatingly poke maintainers to fix such 
> > issues?
> > 
> > If you are saying you will do this job, I can try to redirect such bug 
> > reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> > bug there, assign it to you and create the dependencies that it tracks 
> > the already existing bugs in the kernel Bugzilla.
> 
> Yes, please do this.
> 
> [I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]

Ok, feel free to cc-me, so you are not alone ;-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
