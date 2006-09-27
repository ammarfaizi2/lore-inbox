Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965451AbWI0I61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965451AbWI0I61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWI0I61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:58:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28902 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750902AbWI0I60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:58:26 -0400
Date: Wed, 27 Sep 2006 10:58:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Adrian Bunk <bunk@stusta.de>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927085807.GA24857@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de> <200609270131.46686.rjw@sisk.pl> <20060926233903.GK4547@stusta.de> <200609270712.34082.rjw@sisk.pl> <1159335550.5341.25.camel@nigel.suspend2.net> <20060926230040.fbc86f33.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926230040.fbc86f33.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > If you are saying you will do this job, I can try to redirect such bug 
> > > > reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> > > > bug there, assign it to you and create the dependencies that it tracks 
> > > > the already existing bugs in the kernel Bugzilla.
> > > 
> > > Yes, please do this.
> > > 
> > > [I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]
> > 
> > :) Can I please get copies too?
> 
> Here are some:
> 
> http://bugme.osdl.org/show_bug.cgi?id=5528
> http://bugzilla.kernel.org/show_bug.cgi?id=5945
> http://bugzilla.kernel.org/show_bug.cgi?id=6101
> http://bugzilla.kernel.org/show_bug.cgi?id=5962

> http://bugzilla.kernel.org/show_bug.cgi?id=7057
> http://bugzilla.kernel.org/show_bug.cgi?id=7067
> http://bugzilla.kernel.org/show_bug.cgi?id=7077

Hmm, this series scares me, I wonder if 7087 will be suspend bug, too?

Anyway I went through them and closed the historic ones.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
