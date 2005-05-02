Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVEBWYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVEBWYP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVEBWYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:24:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:40940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbVEBWYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:24:10 -0400
Date: Mon, 2 May 2005 15:20:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: rddunlap@osdl.org, bunk@stusta.de, tomlins@cam.org, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1
Message-Id: <20050502152019.482a830c.akpm@osdl.org>
In-Reply-To: <200505021611.j42GBX5x008308@turing-police.cc.vt.edu>
References: <20050429231653.32d2f091.akpm@osdl.org>
	<Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com>
	<20050430161032.0f5ac973.rddunlap@osdl.org>
	<200505010909.38277.tomlins@cam.org>
	<20050501133040.GB3592@stusta.de>
	<200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
	<20050502084930.6914e152.rddunlap@osdl.org>
	<200505021611.j42GBX5x008308@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 02 May 2005 08:49:30 PDT, "Randy.Dunlap" said:
> 
> > Last I heard, Andrew had access to kernel.org transfer logs,
> > but the problem is that we can't tell anything about the download
> > counts from mirrors.
> 
> Have to admit, I'm always hitting the kernel.org one, because that's the
> URL that Andrew puts in the announcements.  Probably a lot of others do
> so as well - so figure if half the people bother using a mirror rather
> than just going clicky-click, the kernel.org logs will reflect the other
> half.  Probably not perfect, but probably good enough to tell how many
> digits are in the number at least.
> 
> (I'll go out on a limb and say "barely 3 digit's worth of downloads")...

More that you'd expect.

2.6.11-mm1.gz and 2.6.11-mm1.bz2 were downloaded from kernel.org from 1729
unique IP addresses using http and from an additional 321 unique IP
addresses using ftp.

The fact that most people bother to alter the URL from ftp: to http:
perhaps means that more people than I expect also bothered to stick the
country code in there too.  Who knows...

