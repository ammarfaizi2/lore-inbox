Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031241AbWI0XVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031241AbWI0XVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031246AbWI0XVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:21:41 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61711 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031245AbWI0XVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:21:40 -0400
Date: Thu, 28 Sep 2006 01:21:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060927232137.GB3305@stusta.de>
References: <20060925071338.GD9869@suse.de> <200609270131.46686.rjw@sisk.pl> <20060926233903.GK4547@stusta.de> <200609270712.34082.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609270712.34082.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 07:12:33AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, 27 September 2006 01:39, Adrian Bunk wrote:
>...
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

OK, thanks.

I've created #7216, assigned it to you and added Pavel and Nigel to
the Cc.

If in doubt I added a bug to the list, so it might contain some false 
positives.

> Greetings,
> Rafael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

