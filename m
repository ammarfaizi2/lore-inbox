Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWAWF6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWAWF6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWAWF6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:58:00 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27400 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964819AbWAWF57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:57:59 -0500
Date: Mon, 23 Jan 2006 06:57:47 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: menuconfig elements unaligned
Message-ID: <20060123055747.GA8400@mars.ravnborg.org>
References: <Pine.LNX.4.61.0601182118001.29502@yvahk01.tjqt.qr> <20060122210524.2f25d0e5.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122210524.2f25d0e5.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:05:24PM -0800, Randy.Dunlap wrote:
> 
> However, here's another one.  On ARCH=i386, the top-level menu shows
> [ ] Enable doublefault exception handler
> 
> (menuconfig or xconfig)
> This is from arch/i386/Kconfig (line 50).  Surely this should be
> under "Processor type and features" or some other menu, not at the
> top level.
I recall Andrew has a patch in his queue for this one already.
But not sure and no recent -mm handy.

	Sam
