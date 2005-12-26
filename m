Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLZSuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLZSuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 13:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVLZSuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 13:50:21 -0500
Received: from xenotime.net ([66.160.160.81]:57027 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932089AbVLZSuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 13:50:20 -0500
Date: Mon, 26 Dec 2005 10:50:56 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jaco@kroon.co.za, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
Message-Id: <20051226105056.0fc2ebaa.rdunlap@xenotime.net>
In-Reply-To: <1135609521.8293.33.camel@mindpipe>
References: <43AF7724.8090302@kroon.co.za>
	<20051226082934.GD1844@elf.ucw.cz>
	<43AFB005.50608@kroon.co.za>
	<1135609521.8293.33.camel@mindpipe>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 10:05:21 -0500 Lee Revell wrote:

> On Mon, 2005-12-26 at 10:55 +0200, Jaco Kroon wrote:
> > Pavel Machek wrote:
> > > Hi!
> > 
> > >>--- linux-2.6.15-rc6/drivers/char/agp/ati-agp.c.orig	2005-12-25
> > >>22:21:32.000000000 +0200
> > >>+++ linux-2.6.15-rc6/drivers/char/agp/ati-agp.c	2005-12-26
> > >>06:47:26.000000000 +0200
> > > 
> > > 
> > > Your email client did some nasty word wrapping here. I guess the way
> > > to proceed is try #3, this time add my ACK and Cc: akpm...
> > 
> > Right, which clients is recommended for this type of work - mozilla is
> > just not doing it for me any more.  I've heard some decent things about
> > mutt, any other recomendations?
> > 
> > I've mailed off the patch now using mailx but that isn't going to be an
> > option in the long run.
> 
> Um, mozilla is open source - why doesn't someone just fix it, or at
> least report the bug?

It's been done afaik (at least in thunderbird bugzilla).
The answer was something like "just use a plug-in (external) editor."
I tried that, but it (tbird) still truncates trailing whitespace iirc.
They seem to think that it's not a problem.  :(

---
~Randy
