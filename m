Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUCCLCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUCCLC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:02:29 -0500
Received: from gprs40-155.eurotel.cz ([160.218.40.155]:55342 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262434AbUCCLCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:02:05 -0500
Date: Wed, 3 Mar 2004 12:01:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: Code freeze on lite patches and schedule for submission into mainline kernel
Message-ID: <20040303110154.GC342@elf.ucw.cz>
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

There may be better way to get kgdb into mainline.

AFAICS, mainline already contains kgdb/ppc. Submiting "core-lite,
ppc-lite, 8250" would then be simply much needed cleanup. We can push
i386 few days after that.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
