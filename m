Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWI0ApX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWI0ApX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWI0ApX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:45:23 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:21662 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932083AbWI0ApW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:45:22 -0400
Message-ID: <4519C991.4070604@garzik.org>
Date: Tue, 26 Sep 2006 20:45:05 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@linuxmail.org>
CC: suspend2-devel <suspend2-devel@lists.suspend2.net>,
       suspend2-users <suspend2-users@lists.suspend2.net>,
       Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Reporting driver bugs.
References: <1159316745.5341.5.camel@nigel.suspend2.net>
In-Reply-To: <1159316745.5341.5.camel@nigel.suspend2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi everyone.
> 
> I've been involved in a little discussion this morning about reporting
> driver bugs. In the past, I've tended to point people directly to the
> driver author, but I've learnt that the preferred thing is to get people
> to open reports on bugzilla.kernel.org.
> 
> I'm therefore writing to ask if those of you who help with triage could
> point people there as well.

Unfortunately there is no one right answer.  Some driver maintainers 
don't see the bugzilla.kernel.org entry at all; others find it useful 
for tracking purposes.

At the very least, one should make sure the driver author is always CC'd 
on initial bug reports.

	Jeff



