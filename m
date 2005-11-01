Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVKAU7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVKAU7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVKAU7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:59:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7901 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751200AbVKAU7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:59:47 -0500
Date: Tue, 1 Nov 2005 21:59:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: rework swsusp_suspend
Message-ID: <20051101205911.GG7172@elf.ucw.cz>
References: <200510311612.59736.rjw@sisk.pl> <20051031220435.GD14877@elf.ucw.cz> <200511011813.45251.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011813.45251.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Anyway the appended patch contains only changes that you have
> already agreed with, except for the "#ifdef CONFIG_HIGHMEM" thing in swsusp.c
> which originally was in snapshot.c (and bloated the kernel).

ACK.
							Pavel
-- 
Thanks, Sharp!
