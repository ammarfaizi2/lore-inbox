Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVCDMUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVCDMUD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVCDMTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:19:06 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4259 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262256AbVCDLtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:49:42 -0500
Date: Fri, 4 Mar 2005 12:49:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling while atomic errors on swsusp resume
Message-ID: <20050304114929.GR1345@elf.ucw.cz>
References: <1109811404.5918.80.camel@tyrosine> <20050304112649.GQ1345@elf.ucw.cz> <1109935857.5918.99.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109935857.5918.99.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, those are warnings, so it still works, right? Aha, "exited with
> > preempt count 1" seems very wrong. Yes, please try this with
> > vanilla. I'm running 2.6.11 with 
> 
> Yeah, the resume script crashes, which is a bit of a problem. I'll get
> the user to try with a vanilla kernel, but I'm not having these problems
> with an identical kernel - it seems to be something specific to his
> setup.

Make him try it with minimal list of modules, then.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
