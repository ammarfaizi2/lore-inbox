Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTJ3RVf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 12:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTJ3RVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 12:21:35 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:21888 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262686AbTJ3RVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 12:21:34 -0500
Date: Thu, 30 Oct 2003 17:23:38 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200310301723.h9UHNcl2000254@81-2-122-30.bradfords.org.uk>
To: Bill Davidsen <davidsen@tmr.com>, Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1031030113206.6313A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1031030113206.6313A-100000@gatekeeper.tmr.com>
Subject: Re: Linux 2.6.0-test9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > If the idea is to tell people to read the post-Halowe'en doc and a year
> > > of LKML, it is much the same as telling people to wait for a
> > > distribution.
> > 
> > Isn't the purpose of the post-haloween doc to tell people what
> > changed and what needed to be upgraded?  What about the
> > linux/Documentation/Changes file?
> 
> Given that it is a year out of date and general in nature, it's still a
> pretty useful docuement to someone who does a lot of fiddling anyway.
> But what I think would be very useful would be a small (one screen?)
> HTML doc with links to versions which are current today, one page each
> for a few major distros covering tweaks to startup file and the like,
> and a page of things which aren't mentioned in the post Halowe'en doc,
> like the things that aren't available in modules anymore.

Or a filter which takes a 2.4 .config file as input, and outputs the
relevant sections of the post-Haloween document based on that :-).

John.
