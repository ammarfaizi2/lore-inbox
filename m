Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBFT4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBFT4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVBFT4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:56:30 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:50857 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261300AbVBFT42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:56:28 -0500
Date: Sun, 6 Feb 2005 20:56:48 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/input/gameport/cs461x.c: remove bouncing email address
Message-ID: <20050206195648.GC25173@ucw.cz>
References: <20050206193013.GB3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206193013.GB3129@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 08:30:14PM +0100, Adrian Bunk wrote:
> This patch remoces the bouncing email address of Victor Krapivin from 
> MODULE_AUTHOR.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c.old	2005-02-06 20:24:35.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/input/gameport/cs461x.c	2005-02-06 20:24:49.000000000 +0100
> @@ -16,7 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  
> -MODULE_AUTHOR("Victor Krapivin <vik@belcaf.minsk.by>");
> +MODULE_AUTHOR("Victor Krapivin");
>  MODULE_LICENSE("GPL");
 
Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
