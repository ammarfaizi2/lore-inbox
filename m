Return-Path: <linux-kernel-owner+w=401wt.eu-S932778AbWLNUUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWLNUUd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWLNUUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:20:33 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:43708 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbWLNUUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:20:32 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Ben Collins <ben.collins@ubuntu.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <200612142029.47753.mb@bu3sch.de>
References: <20061214003246.GA12162@suse.de> <4580E37F.8000305@mbligh.org>
	 <1166105545.6748.212.camel@gullible>  <200612142029.47753.mb@bu3sch.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 15:19:54 -0500
Message-Id: <1166127594.6748.295.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 20:29 +0100, Michael Buesch wrote:
> On Thursday 14 December 2006 15:12, Ben Collins wrote:
> > You can't talk about drivers that don't exist for Linux. Things like
> > bcm43xx aren't effected by this new restriction for GPL-only drivers.
> > There's no binary-only driver for it (ndiswrapper doesn't count). If the
> > hardware vendor doesn't want to write a driver for linux, you can't make
> > them. You can buy other hardware, but that's about it.
> 
> Not that is matters in this discussion, but there are binary Broadcom
> 43xx drivers for linux available.
> 
> > Here's the list of proprietary drivers that are in Ubuntu's restricted
> > modules package:
> > 
> > 	madwifi (closed hal implementation, being replaced in openhal)
> > 	fritz
> 
> Well, that's not just one, right?
> That's like, 10 or so for the different AVM cards.
> I'm just estimating. Correct me, if I'm wrong.

One driver, many variations of the chipset. That's true of most drivers.

> (And if I didn't mention it yet; AVM binary drivers are
> complete crap.)

Wont disagree with you there.
