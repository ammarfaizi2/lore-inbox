Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272592AbTHEJLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272599AbTHEJLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:11:17 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:57052 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272592AbTHEJLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:11:15 -0400
Date: Tue, 5 Aug 2003 11:10:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Power Management Updates
Message-ID: <20030805091020.GA388@elf.ucw.cz>
References: <Pine.LNX.4.44.0308041806060.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041806060.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here is a set of Power Management changes that contain the changes Pavel 
> has been trying to push to you for a couple of weeks now. They have been 
> split up into individual changesets and hand merged to be a bit cleaner 
> than the original patches. 
> 
> These also contain initial efforts to start cleaning up swsusp by 
> splitting out shareable functionality and moving the whole lot from 
> kernel/suspend.c into kernel/power/*.c. 
> 
> The tree can be pulled from:
> 
> 	bk://kernel.bkbits.net/home/mochel/linux-2.5-power
> 
> The changesets are described below. 
> 
> Individual patches can be viewed here: 
> 
> 	http://developer.osdl.org/~mochel/patches/aug4/power/
> 
> I will not be sending them, as some of them are quite large (from moving 
> files/directories). 
> 
> Pavel: please review and let me know if I missed anything important, so I 
> can (quickly) fix it up. 

They look good, very good, Linus please apply.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
