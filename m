Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUCCK5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbUCCK5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:57:22 -0500
Received: from gprs40-155.eurotel.cz ([160.218.40.155]:52194 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262430AbUCCK5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:57:21 -0500
Date: Wed, 3 Mar 2004 11:56:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: Code freeze on lite patches and schedule for submission into mainline kernel
Message-ID: <20040303105653.GB342@elf.ucw.cz>
References: <200403031354.10370.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403031354.10370.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We have two sets of kgdb patches as of now: [core-lite, i386-lite, 8250] and 
> [core, i386, ppc, x86_64, eth]. First set of kgdb patches (lite) is fairly 
> clean. Let's consider it to be a candicate for submission to mainline kernel.
> 
> I am freezing the lite patches wrt. feature updates. Only bug-fixes and code 
> cleanups will be allowed in lite patches. You can make any feature 
> enhancements to second set of patches.

Sounds good.

> I propose following schedule for pushing kgdb lite into mainline kernel:
> Take 1: 8th , Take 2: 15th, Take 3: 22nd, Take 4:29th. I'll download the 
> kernel snapshot (http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/) on 
> these dates and submit a single patch for possible acceptance into mainline 
> kenrel and feedback from community. Hopefully we'll succeed by end of this 
> month.

Well, you should have really cc-ed this one to andrew :-). [What?
Schedule for pushing? No patchbombing? ;-))))))))))]
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
