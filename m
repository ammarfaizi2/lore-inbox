Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWGGJjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWGGJjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGGJjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:39:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65173 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932093AbWGGJjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:39:20 -0400
Date: Fri, 7 Jul 2006 11:38:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Integrate asus_acpi LED's with new LED subsystem
Message-ID: <20060707093855.GB24099@elf.ucw.cz>
References: <20060706193157.GC14043@phoenix> <20060706235020.GA4821@elf.ucw.cz> <20060707014428.GC8900@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707014428.GC8900@phoenix>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Apart from codingstyle issues...
> 
> I've fixed a bunch that Andrew Morton and Richard Purdie mentioned
> (since your message, I've posted a new revision).  Are there any changes
> I missed?
> 
> > yes, it looks good.
> 
> Nice. :-)
> 
> > Hooking various
> > leds into led subsystem is way better than having all the separate
> > drivers.
> 
> Yes.  The LED subsystem is a really cool idea, because what good are
> blinkenlights if you have to write shell scripts to control them?  The
> kernel should do that for you!  (/me wishes someone made a laptop with
> something like 8 LED's of different colors, so he could just make them
> do what he liked.)

Attach them to parallel port... I've done that long time ago. You can
place 12 leds there...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
