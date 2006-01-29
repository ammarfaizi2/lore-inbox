Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWA2XeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWA2XeF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWA2XeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:34:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26629 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932080AbWA2XeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:34:04 -0500
Date: Mon, 30 Jan 2006 00:34:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060129233403.GA3777@stusta.de>
References: <20060129144533.128af741.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc1-mm3:
>...
> +i386-add-a-temporary-to-make-put_user-more-type-safe.patch
> 
>  x86 fixes/features
>...

This patch generates so many "ISO C90 forbids mixed declarations and code"
warnings that I start to consider Andrew's rejection of my "mark 
virt_to_bus/bus_to_virt as __deprecated on i386" patch due to the 
warnings it generates a personal insult...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

