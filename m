Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbTEPTv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTEPTv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:51:59 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:1763 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S264569AbTEPTv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:51:58 -0400
Date: Fri, 16 May 2003 21:55:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop mode, #2
Message-ID: <20030516195535.GC372@elf.ucw.cz>
References: <20030516113309.GY812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516113309.GY812@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Made a few tweaks and adjustments:
> 
> - If block_dump is set, also dump who is marking a page/buffer as dirty.
>   akpm recommended this.
> 
> - Don't touch default bdflush parameters (see script)
> 
> That's about it. I've gotten several mails who really like the patch and
> that it really adds a non-significant amount of extra battery
> time. I

Non-significant? Like it adds no time at all?

> consider the patch final at this point.
> 
> Patch is against 2.4.21-rc2 (ish)

It looks nice, but without Documentation/laptop_mode, I can't say much
more ;-)))).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
