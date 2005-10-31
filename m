Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVJaMtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJaMtB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVJaMtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:49:00 -0500
Received: from styx.suse.cz ([82.119.242.94]:27269 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932438AbVJaMtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:49:00 -0500
Date: Mon, 31 Oct 2005 13:48:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [GIT PULL] Tiny input update
Message-ID: <20051031124859.GD18147@ucw.cz>
References: <200510310200.31728.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310200.31728.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:00:31AM -0500, Dmitry Torokhov wrote:
> Linus,
> 
> Please consider pulling from:
> 
> 	www.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> 
> The tree contains several one-liners, mostly dealing with the breakages
> introduced by input dynalloc conversion:
> 
> Changes:
>     Input: adbhid - fix OOPS introduced by dynalloc conversion (Paul Mackerras)
>     Input: lkkbd - fix debug message in lkkbd_interrupt()
>     Input: pcspkr - fix setting name and phys for the device
>     Input: fix input_dev registration message
>     Input: evdev - allow querying SW state from compat ioctl
>     Input: evdev - allow querying EV_SW bits from compat_ioctl
> 
> The combined patch is below.

All the changes have my OK. Linus, please do the pull. Dmitry: Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
