Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUDVHtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUDVHtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUDVHry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:47:54 -0400
Received: from styx.suse.cz ([82.208.2.94]:3200 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263815AbUDVH1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:27:03 -0400
Date: Thu, 22 Apr 2004 09:27:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/15] New set of input patches: lkkbd whitespace
Message-ID: <20040422072744.GC340@ucw.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210052.28755.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210052.28755.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 12:52:25AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1905, 2004-04-20 22:25:18-05:00, dtor_core@ameritech.net
>   Input: fix spelling and trailing whitespaces in lkkbd
> 
> 
>  lkkbd.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
> ===================================================================
> 
> 
> 
> diff -Nru a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
> --- a/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> +++ b/drivers/input/keyboard/lkkbd.c	Tue Apr 20 23:00:57 2004
> @@ -12,7 +12,7 @@
>   * adaptor).
>   *
>   * DISCLAUNER: This works for _me_. If you break anything by using the

If you're fixing typos, you should also fix the DISCLAUNER. ;)

> - * information given below, I will _not_ be lieable!
> + * information given below, I will _not_ be liable!
>   *
>   * RJ11 pinout:		To DB9:		Or DB25:
>   * 	1 - RxD <---->	Pin 3 (TxD) <->	Pin 2 (TxD)
> @@ -39,18 +39,18 @@
>  /*
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or 
> + * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
