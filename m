Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268219AbUH3Sww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268219AbUH3Sww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbUH3S1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 14:27:25 -0400
Received: from mail.zmailer.org ([62.78.96.67]:26584 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S268856AbUH3SSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 14:18:25 -0400
Date: Mon, 30 Aug 2004 21:18:21 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       James Colannino <lkml@colannino.org>, linux-kernel@vger.kernel.org
Subject: Re: submitting kernel patch for 3w-9xxx in 2.4
Message-ID: <20040830181821.GQ19844@mea-ext.zmailer.org>
References: <413217A3.4020906@colannino.org> <20040829182333.GP19844@mea-ext.zmailer.org> <Pine.LNX.4.61.0408291433210.32154@twin.uoregon.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408291433210.32154@twin.uoregon.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 02:35:47PM -0700, Joel Jaeggli wrote:
> On Sun, 29 Aug 2004, Matti Aarnio wrote:
> >On Sun, Aug 29, 2004 at 10:51:31AM -0700, James Colannino wrote:
> >>Everyone,
> >>
> >>I've created a kernel patch for 2.4.27 that adds the newer 3w-9xxx 3Ware
> >>driver (for the 3Ware 9000 series of controllers).  If anyone here is
> >>interested, I can patch the latest pre-release for 2.4.28 and submit it
> >>to the list.  Just let me know.
> >>
> >>http://james.colannino.org/downloads/patches/3w-9xxx-2.4.27.diff
> >
> >May I suggest you don't use triple-x in its name.
> >Such causes indigestion by several spam filters that people have
> >deployed...  (The aic7xxx as prime example.)
> 
> got another identifier that would indicate a presence of a variable that 
> won't have some other meaning to a filesystem or user? #### ???? *

No idea about that, but every time somebody reports problems with
the AIC7XXX driver with either in all uppercase, or lowercase
name in message subject, a dozen or so linux-kernel recipient systems
do react adversely with something like "keep your spam".

For number wildcarding,  "N" is usable in some cases.
e.g.  3w-9nnn  

I do urge you to consider rewriting configuration options, and file
names so that triple-x doesn't appear in them.

Both for 2.4 and 2.6 kernels, as well.

> >>James
> >
> >/Matti Aarnio

/Matti Aarnio
