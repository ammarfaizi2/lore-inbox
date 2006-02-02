Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423045AbWBBBlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbWBBBlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423047AbWBBBlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:41:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62223 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423045AbWBBBlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:41:24 -0500
Date: Thu, 2 Feb 2006 02:41:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: missing license tag in intermodule.
Message-ID: <20060202014120.GV3986@stusta.de>
References: <20060201230254.GA3413@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201230254.GA3413@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 06:02:55PM -0500, Dave Jones wrote:

> It may suck something awful, but it shouldn't taint the kernel.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.15.noarch/kernel/intermodule.c~	2006-02-01 18:01:39.000000000 -0500
> +++ linux-2.6.15.noarch/kernel/intermodule.c	2006-02-01 18:01:47.000000000 -0500
> @@ -179,3 +179,6 @@ EXPORT_SYMBOL(inter_module_register);
>  EXPORT_SYMBOL(inter_module_unregister);
>  EXPORT_SYMBOL(inter_module_get_request);
>  EXPORT_SYMBOL(inter_module_put);
> +
> +MODULE_LICENSE("GPL");
> +

Sorry, my fault.

Acked-by: Adrian Bunk <bunk@stusta.de

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

