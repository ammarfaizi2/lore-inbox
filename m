Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbSLKPTA>; Wed, 11 Dec 2002 10:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbSLKPTA>; Wed, 11 Dec 2002 10:19:00 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:58622 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267182AbSLKPS7>; Wed, 11 Dec 2002 10:18:59 -0500
Date: Wed, 11 Dec 2002 08:19:50 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Framebuffer problems, 2.4.20-rc2, 2.5.51
In-Reply-To: <200212110955.39586.ivg2@cornell.edu>
Message-ID: <Pine.LNX.4.33.0212110818490.28554-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.5.51:
> 	Kernel freezes upon loading the ATYFB driver.
> 	No error messages. Sysrq has no effect.
>
> 	Riva (tested without atyfb) shows a black screen, apparently
> 	followed by a kernel freeze since Sysrq has no effect.
>
> 	Kernel without boots without framebuffer, so the framebuffer causes the
> freeze.

Did you enable framebuffer console in the console sub menu?



