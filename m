Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbTJ3IRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 03:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTJ3IRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 03:17:54 -0500
Received: from gprs199-225.eurotel.cz ([160.218.199.225]:1408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262274AbTJ3IRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 03:17:52 -0500
Date: Thu, 30 Oct 2003 09:13:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6 features list update
Message-ID: <20031030081359.GA297@elf.ucw.cz>
References: <E1ADzPx-0002Hl-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ADzPx-0002Hl-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I think the section entitled "Laptops" is overly optimistic.  First,
> as far as i know, suspend-to-disk has only this week been announced
> (on this mailing list) for anything other than the i386 platform, and
> even there, many laptops only marginally work with software suspend/
> suspend-to-disk.  I really doubt that any file system utilizing USB or
> ieee1394 is going to work reliably (if at all) with suspend for many
> laptops in the near future.  I think the 2.6.0 shakedown and the amount
> of attention (or lack thereof) given to suspend-related bugs makes it
> clear that suspend-to-disk/software suspend is still experimental in
> this release.
> 
> I sincerely hope that changes very soon and i will do what i can to 
> help.  Meanwhile, please qualify that section to read:
> 
>    ... now supports full software-suspend-to-disk functionality on many
> 								-------
>    laptops for the Linux user on the go.
>    -------				  [emphasis to show added text]
> 
> It's definitely improved, but in many instances (especially where the 
> laptop manufacturer has not provided full hardware/BIOS documentation),
> it does not work well and may be difficult to make reliable in the near
> future.

swsusp is not limited to laptops, and no we do not much bios
documentation. It also worked on x86-64 for half a year...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
