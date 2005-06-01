Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFAOSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFAOSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFAORC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:17:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16291 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261388AbVFAOKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:10:49 -0400
Date: Wed, 1 Jun 2005 16:02:33 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm2
Message-ID: <20050601140233.GD1940@openzaurus.ucw.cz>
References: <20050601022824.33c8206e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601022824.33c8206e.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm2/
> 
> 
> - Dropped bk-acpi.patch.  Too old, too much breakage.
> 
> - A few more subsystem trees have moved to using git

Have you considered publishing -mm using git?

I guess your workflow prevents you from really using git,
but even just publishing releases using git would be great.

(Just now I'm tracking Linus with my tree.  git makes that quite easy.
Tracking -mm is ugly manual work with diff, patch and ketchup...)
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

