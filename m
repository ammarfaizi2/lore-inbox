Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932988AbWF3SDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbWF3SDE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbWF3SDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:03:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36064 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932986AbWF3SDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:03:00 -0400
Date: Fri, 30 Jun 2006 20:01:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Johan Vromans <jvromans@squirrel.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: swsusp problems with 2.6.17-1.2139_FC5
Message-ID: <20060630180141.GC9225@elf.ucw.cz>
References: <m2irmj9937.fsf@phoenix.squirrel.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2irmj9937.fsf@phoenix.squirrel.nl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp has problems resumeing after upgrading my Acer Travelmate
> 4001WLMi from 2.6.16 to 2.6.17. Note that I'm running a Fedora 5
> kernel, with the ATI proprietary video driver.

Stop right here. Can you reproduce the problem without ATI driver?
Reproducing it on vanilla kernel (not -FC5) would be nice, too.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
