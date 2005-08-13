Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVHMXPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVHMXPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 19:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVHMXPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 19:15:32 -0400
Received: from ns1.suse.de ([195.135.220.2]:22755 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932398AbVHMXPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 19:15:32 -0400
Date: Sun, 14 Aug 2005 01:15:31 +0200
From: Olaf Hering <olh@suse.de>
To: Henrik Brix Andersen <brix@gentoo.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050813231531.GA29706@suse.de>
References: <1123969015.13656.13.camel@sponge.fungus> <1123970037.13656.16.camel@sponge.fungus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1123970037.13656.16.camel@sponge.fungus>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 13, Henrik Brix Andersen wrote:

> On Sat, 2005-08-13 at 23:36 +0200, Henrik Brix Andersen wrote:
> > Here's a patch for unifying the watchdog device node name
> > to /dev/watchdog as expected by most user-space applications.
> > 
> > Please CC: me on replies as I am not subscribed to LKML.
> > 
> > 
> > Signed-off-by: Henrik Brix Andersen <brix@gentoo.org>
> 
> The last patch was accidentally against 2.6.12 - this one is against
> 2.6.13-rc6.

A patch like that is sitting in -mm since almost 5 months. I wonder why
it was never merged.
