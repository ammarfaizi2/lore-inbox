Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWHFXQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWHFXQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWHFXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:16:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40206 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750766AbWHFXQd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:16:33 -0400
Date: Sun, 6 Aug 2006 23:16:22 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Brannon Barrett Klopfer <bklopfer@stanford.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Completely dead on resume (no caps lock, nada)
Message-ID: <20060806231621.GE4205@ucw.cz>
References: <1154721378.44d3a6627e951@webmail.stanford.edu> <20060804215957.GA7008@nineveh.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804215957.GA7008@nineveh.rivenstone.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Sorry to bug the entire list with such a vaugue post, but I'm not sure what
> > driver/subsystem is causing this problem. I'm sure you all are sick of "My
> > computer won't suspend, what do I do?" posts, but...well, my computer won't
> > suspend...
> 
>     If no one reports bugs, they don't get fixed.
> 
>     Pavel Machek <pavel@suse.cz> is the swsusp maintainer, and should
> have been CC'd on this, otherwise he'll probably never see it.
> Linux-kernel is a busy place. :-)

Actually I probably would see it, just a little later.

Also I'm maintainer for swsusp. I tend to look after s2ram, too, so
cc-ing me will not hurt, but I do not maintain it.

Best place to ask is probably suspend-devel mailing list at
sourceforge's suspend project.

>     I know Mr. Machek wants swsusp bug reports filed in Bugzilla at
> http://bugzilla.kernel.org , so you should do that, and then send a
> follow up to this, CC'd to Pavel, with a bugzilla bug number.

Actually I prefer 'simple' bugs to go via mail to suspend-devel... and
keep bugzilla for 'interesting' issues.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
