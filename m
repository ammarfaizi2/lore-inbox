Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUBXWPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUBXWPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:15:55 -0500
Received: from gprs144-166.eurotel.cz ([160.218.144.166]:61056 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262420AbUBXWPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:15:53 -0500
Date: Tue, 24 Feb 2004 23:15:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Split kgdb into "lite" and "normal" parts
Message-ID: <20040224221541.GA9145@elf.ucw.cz>
References: <20040218225010.GH321@elf.ucw.cz> <200402191322.52499.amitkale@emsyssoft.com> <20040224213908.GD1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224213908.GD1052@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Tested (core-lite.patch + i386-lite.patch + 8250.patch) combination.
> > Looks good.
> > 
> > Let's first check this in and then do more cleanups.
> > Tom, does it sound ok?
> 
> This sounds fine to me.  Pavel, I'm guessing you did this with quilt,
> could you provide some pointers on how to replicate this in the future?

Unfortunately, I done it by hand :-(. But if -lite parts are not
merged, soon, I'll be forced to start using quilt. Doing stuff by hand
is quite painfull...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
