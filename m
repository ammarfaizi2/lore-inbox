Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbTHUBRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbTHUBRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:17:40 -0400
Received: from www.13thfloor.at ([212.16.59.250]:4320 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262381AbTHUBRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:17:37 -0400
Date: Thu, 21 Aug 2003 03:17:48 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Disconnect <lkml@sigkill.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Patchset] 2.4.22-rc1-dis7 released
Message-ID: <20030821011747.GA13095@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Disconnect <lkml@sigkill.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <1060186101.2016.49.camel@slappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1060186101.2016.49.camel@slappy>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

On Wed, Aug 06, 2003 at 12:08:22PM -0400, Disconnect wrote:
> I've rolled out 2.4.22-rc1-dis7. Not as well tested as some of the
> others (hey, gimme a break, rc1 was only out for about 2 hours when I
> released this..) but its about due, and I've been running it with the
> newer -pre kernels for quite a while.
> 
> As always, its available at http://www.gotontheinter.net/
> 
> This patch contains:
>  - Swsusp 1.1-pre3
>  - Swsuspctl
>  - Laptop-mode
>  - Preempt

would it be possible to get the preemtion patch
as separate diff for 2.4.22-rc1 or even better 2.4.22-rc2?

TIA,
Herbert

>  - Standard BCM4400 driver (backported from 2.5); the old driver has not
> been removed, just disabled in the menus
>  - Warmboot by default
>  - Updated Inspiron 8500 DSDT
>  - Updated Radeon DRM
>  - Bootsplash (www.bootsplash.org)
>  - Supermount
>  - O_Direct
>  - Packet mode for cd/dvd writing
>  - Optionally disable trackpad while typing
>  - Handle windows .lnk files as symlinks under vfat
>  - O_Streaming
>  - Monitor mode for Orinoco pcmcia/mini-pci cards
>  - CPUfreq
>  - Allow network devices to contribute to /dev/random
> 
> This one should cover most everything thats been requested; if there is
> anything you'd love to see, let me know where to find it and I'll see
> what I can do.
> 
> -- 
> Disconnect <lkml@sigkill.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
