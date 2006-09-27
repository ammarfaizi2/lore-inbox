Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965370AbWI0GEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbWI0GEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbWI0GEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:04:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:173 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965375AbWI0GEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:04:14 -0400
Date: Tue, 26 Sep 2006 23:00:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Adrian Bunk <bunk@stusta.de>,
       Pavel Machek <pavel@ucw.cz>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060926230040.fbc86f33.akpm@osdl.org>
In-Reply-To: <1159335550.5341.25.camel@nigel.suspend2.net>
References: <20060925071338.GD9869@suse.de>
	<200609270131.46686.rjw@sisk.pl>
	<20060926233903.GK4547@stusta.de>
	<200609270712.34082.rjw@sisk.pl>
	<1159335550.5341.25.camel@nigel.suspend2.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 15:39:10 +1000
Nigel Cunningham <ncunningham@linuxmail.org> wrote:

> > > If you are saying you will do this job, I can try to redirect such bug 
> > > reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> > > bug there, assign it to you and create the dependencies that it tracks 
> > > the already existing bugs in the kernel Bugzilla.
> > 
> > Yes, please do this.
> > 
> > [I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]
> 
> :) Can I please get copies too?

Here are some:

http://bugme.osdl.org/show_bug.cgi?id=5528
http://bugzilla.kernel.org/show_bug.cgi?id=5945
http://bugzilla.kernel.org/show_bug.cgi?id=6101
http://bugzilla.kernel.org/show_bug.cgi?id=5962
http://bugzilla.kernel.org/show_bug.cgi?id=7057
http://bugzilla.kernel.org/show_bug.cgi?id=7067
http://bugzilla.kernel.org/show_bug.cgi?id=7077

(Some are probably fixed: I desparately need to go through all these
and refresh everything)
