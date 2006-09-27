Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWI0BUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWI0BUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 21:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWI0BUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 21:20:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30417 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932205AbWI0BUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 21:20:31 -0400
Date: Tue, 26 Sep 2006 18:15:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>,
       suspend2-users <suspend2-users@lists.suspend2.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Reporting driver bugs.
Message-Id: <20060926181557.16a19343.akpm@osdl.org>
In-Reply-To: <4519C991.4070604@garzik.org>
References: <1159316745.5341.5.camel@nigel.suspend2.net>
	<4519C991.4070604@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 20:45:05 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Nigel Cunningham wrote:
> > Hi everyone.
> > 
> > I've been involved in a little discussion this morning about reporting
> > driver bugs. In the past, I've tended to point people directly to the
> > driver author, but I've learnt that the preferred thing is to get people
> > to open reports on bugzilla.kernel.org.
> > 
> > I'm therefore writing to ask if those of you who help with triage could
> > point people there as well.
> 
> Unfortunately there is no one right answer.  Some driver maintainers 
> don't see the bugzilla.kernel.org entry at all; others find it useful 
> for tracking purposes.
> 
> At the very least, one should make sure the driver author is always CC'd 
> on initial bug reports.
> 

I screen all bugzilla reports and ensure that each one gets to the appropriate developer, if there is one.
