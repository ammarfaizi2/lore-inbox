Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423490AbWKHUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423490AbWKHUex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423499AbWKHUew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:34:52 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54734 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423490AbWKHUev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:34:51 -0500
Subject: Re: [PATCH] pci quirks: Sort out the VIA mess once and for
	all	(hopefully)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <45523848.7010709@gentoo.org>
References: <1163003156.23956.40.camel@localhost.localdomain>
	 <45523848.7010709@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 20:39:16 +0000
Message-Id: <1163018356.23956.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 15:04 -0500, ysgrifennodd Daniel Drake:
> Hi Alan,
> 
> Thanks for spending time working on this. Sorry that I never followed up 
> after my previous attempt, I've been really busy having starting a 
> proper job.

No problem. As if I don't leave a wake of things other people pick up
when I get too busy 8)

> I just noticed that my earlier patch is included as of 2.6.19-rc, so 
> actually your patch applies there and results can be compared. (if 
> you're in strong objection to it's mainline inclusion, I could ask for 
> it to be reverted, but it at does solve a lot of problems for users over 
> the previous state with no reported problems...)

I think your patch is going to break stuff, without the patch will break
more, and hopefully this patch will not break anything - but there is
risk. I think it's up to Linus what he wants to do for .19

Alan

