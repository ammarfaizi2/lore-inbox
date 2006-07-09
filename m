Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWGIVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWGIVKX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWGIVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:10:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21699 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161156AbWGIVKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:10:21 -0400
Subject: Re: 2.6.18-rc1-mm1
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-acpi@vger.kernel.org,
       rdunlap@xenotime.net, greg@kroah.com, Andi Kleen <ak@muc.de>
In-Reply-To: <20060709052252.8c95202a.akpm@osdl.org>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <44B0E6E6.6070904@reub.net>  <20060709052252.8c95202a.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:10:14 -0700
Message-Id: <1152479414.21576.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 05:22 -0700, Andrew Morton wrote:
> On Sun, 09 Jul 2006 23:22:14 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > Note also the message midway through about losing some ticks, which if I recall 
> > correctly is not new to this -mm release.  I'm not sure who to cc about this.
> 
> John stuff.  I suspect it's natural and normal, if the IDE error handling
> did something rude with interrupt holdoff.

Actually that's an x86-64 system, so the timekeeping changes shouldn't
really being affecting it.

thanks
-john

