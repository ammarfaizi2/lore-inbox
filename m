Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTJaAH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTJaAH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:07:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:30361 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262971AbTJaAH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:07:27 -0500
Date: Thu, 30 Oct 2003 16:07:19 -0800
From: cliff white <cliffw@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 vs sound
Message-Id: <20031030160719.76bee7f6.cliffw@osdl.org>
In-Reply-To: <200310301008.27871.gene.heskett@verizon.net>
References: <200310301008.27871.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 10:08:27 -0500
Gene Heskett <gene.heskett@verizon.net> wrote:

> Where can I find a step by step tutorial on installing alsa since OSS 
> has been deprecated?  I've been using the shareware OSS on this mobo 
> for years, the audio chipset is VIA 8233 family.  I have as much of 
> it compiled into the kernel as there are checkmarks in kconfig but 
> nothing soundwise is working yet.  I also put that LXD option on the 
> grub line, but thats being ignored, the dmesg comment is still there.
> If grub.conf wasn't where it goes, please advise on that too.
> 
> I've been booted to this for about 10 hours now, and so far sound is 
> the only thing not working that I've needed.  Not all of my usb stuff 
> has been exercized yet though.
> 
> So far it just plain feels good, congrats to all involved.
> 
> Mmm, the pair of warnings about the check_region call being deprecated 
> are still there in the advansys driver, but it worked normally for 
> amanda last night.

I would start from the source:
http://alsa-project.org/documentation.php3
Or, try the Linux Audio Users Guide:

http://www.djcj.org/LAU/guide/index.php

A setup guide for the via8233, with module config info is here:

http://alsa.opensrc.org/index.php?page=via8233

cliffw


> 
> -- 
> Cheers, Gene
> AMD K6-III@500mhz 320M
> Athlon1600XP@1400mhz  512M
> 99.27% setiathome rank, not too shabby for a WV hillbilly
> Yahoo.com attornies please note, additions to this message
> by Gene Heskett are:
> Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
