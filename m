Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFCKM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFCKM1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFCKM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:12:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33477 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261207AbVFCKMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:12:22 -0400
Date: Fri, 3 Jun 2005 12:12:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm2
Message-ID: <20050603101203.GA2734@elf.ucw.cz>
References: <20050601022824.33c8206e.akpm@osdl.org> <20050601140233.GD1940@openzaurus.ucw.cz> <pan.2005.06.01.15.04.49.64662@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.06.01.15.04.49.64662@smurf.noris.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/
> >> 
> >> 
> >> - Dropped bk-acpi.patch.  Too old, too much breakage.
> >> 
> >> - A few more subsystem trees have moved to using git
> > 
> > Have you considered publishing -mm using git?
> > 
> > I guess your workflow prevents you from really using git, but even just
> > publishing releases using git would be great.
> > 
> > (Just now I'm tracking Linus with my tree.  git makes that quite easy.
> > Tracking -mm is ugly manual work with diff, patch and ketchup...)
> 
> I have written a script (actually a leftover from the mm-to-BK import
> days) that pulls -mm into git as individual commits.

Great! Would it be possible to export results of your script
somewhere? I guess you could get kernel.org account for this...
								Pavel
