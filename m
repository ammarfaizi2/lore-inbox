Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUB2HaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUB2HaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:30:13 -0500
Received: from gprs148-124.eurotel.cz ([160.218.148.124]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261996AbUB2HaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:30:09 -0500
Date: Sun, 29 Feb 2004 08:30:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040229072959.GB209@elf.ucw.cz>
References: <20040228230039.GA246@elf.ucw.cz> <1078012320.906.9.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078012320.906.9.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 29-02-04 10:52:01, Benjamin Herrenschmidt wrote:
> On Sun, 2004-02-29 at 10:00, Pavel Machek wrote:
> > Hi!
> > 
> > Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> > It seems noone is maintaining it, equivalent functionality is provided
> > by swsusp, and it is confusing users...
> 
> Except that pmdisk code is +/- readable, swsusp is not...

Would you be willing to either maintain pmdisk or (preffered) split it
up and submit me pieces?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
