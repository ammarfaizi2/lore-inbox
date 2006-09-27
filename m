Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWI0AUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWI0AUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWI0AUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:20:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbWI0AUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:20:06 -0400
Date: Tue, 26 Sep 2006 17:16:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Pavel Machek <pavel@ucw.cz>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060926171644.6ccdaf7f.akpm@osdl.org>
In-Reply-To: <20060926233903.GK4547@stusta.de>
References: <20060925071338.GD9869@suse.de>
	<20060926223146.GI4547@stusta.de>
	<1159311915.7485.37.camel@nigel.suspend2.net>
	<200609270131.46686.rjw@sisk.pl>
	<20060926233903.GK4547@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 01:39:03 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> Who will track these bugs, debug them (who is e.g. responsible for 
> kernel Bugzilla #6035?) and repeatingly poke maintainers to fix such 
> issues?

Known issue...  I'll be spending more time on it, short-term, hopefully.

> If you are saying you will do this job, I can try to redirect such bug 
> reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> bug there, assign it to you and create the dependencies that it tracks 
> the already existing bugs in the kernel Bugzilla.

For now, yes, please let's make sure that these things are in bugzilla -
the important thing here is to capture the identity of the reporter.  
