Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUEUJOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUEUJOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 05:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUEUJOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 05:14:53 -0400
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:24704 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265426AbUEUJOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 05:14:52 -0400
Date: Fri, 21 May 2004 11:14:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rajsekar <raj.delete.se.here.too.kar@peacock.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp also stores system clock
Message-ID: <20040521091414.GA15874@elf.ucw.cz>
References: <y49oeonr88c.fsf@sahana.cs.iitm.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y49oeonr88c.fsf@sahana.cs.iitm.ernet.in>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I started liking swsusp so much that I dont shutdown my system anymore, I
> just suspend.  Is this wrong? 
> 
> But I noticed that the clock also gets saved and when I resume my system,
> the clock is annoyingly wrong.  I suppose that this is done on purpose for
> some reasons by the developers.
> 
> Currently, I use hwclock to set my system clock on resume.
> 
> Is there a better way or a patch ?

Which kernel?

I thought I fixed that in 2.6.
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
