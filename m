Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269402AbUINMZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269402AbUINMZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269361AbUINMXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:23:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:13757 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269362AbUINMW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:22:27 -0400
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914114341.GS2336@suse.de>
References: <20040914060628.GC2336@suse.de>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
	 <20040914070649.GI2336@suse.de> <20040914071555.GJ2336@suse.de>
	 <1095156542.16570.7.camel@localhost.localdomain>
	 <20040914111207.GR2336@suse.de>
	 <1095158149.16520.24.camel@localhost.localdomain>
	 <20040914114341.GS2336@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095160759.16572.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 12:19:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 12:43, Jens Axboe wrote:
> > I've nothing against a well documented "actually I have a cache" option
> > with appropriate warnings (and of course possibly a whitelist if we can
> > get vendors to help). But one that like hdparm does bother to note when
> > you may be playing with fire.
> 
> You should be able to turn on support from user space, if you so wish,
> if you know that the drive works.

No argument there at all. A whitelist would be nice also.

