Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWIGT0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWIGT0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWIGT0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:26:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52745 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751864AbWIGT0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:26:14 -0400
Date: Thu, 7 Sep 2006 19:22:34 +0000
From: Pavel Machek <pavel@suse.cz>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is the expected behaviour under extreme high load.
Message-ID: <20060907192234.GF8793@ucw.cz>
References: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4e42d10609061653p608a2947g1943b3d752855dfe@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am running a stress test on my SunFire 4600 (8x2core, 
> 64G) using the
> mem_test available from
> http://carpanta.dc.fi.udc.es/~quintela/memtest. I am 
> using SuSE
> enterprise 9 SP3.

Try running w/o watchdog.

> I am wondering what is the expected behaviour of a 
> machine under
> extreme VM stress.
> When I stress the system to the limits, it practically 
> becomes
> unresponsive. It runs for almost half an hour and then 
> it crashes
> because of a CPU lockup.

> Any pointers from where I can start debugging this issue?

Try vanilla kernel, first...

-- 
Thanks for all the (sleeping) penguins.
