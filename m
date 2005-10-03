Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVJCSmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVJCSmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVJCSmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:42:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932586AbVJCSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:42:17 -0400
Date: Mon, 3 Oct 2005 20:42:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "alpha @ steudten Engineering" <alpha@steudten.com>
Cc: LinuxAlpha <linux-alpha@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel-2.6.13.2: MISSING: asm-alpha/diskdump.h
Message-ID: <20051003184214.GF3652@stusta.de>
References: <434177A4.8070101@steudten.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434177A4.8070101@steudten.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:25:40PM +0200, alpha @ steudten Engineering wrote:
> 
> The file asm-alpha/diskdump.h is missing in the 2.6.13 patch .2
> build for alpha arch.
> 
> The build breaks also with # CONFIG_DISKDUMP is not set

I don't know what you call "2.6.13 patch .2", but it's not kernel 
2.6.13.2 from ftp.kernel.org which doesn't contain diskdump support.

Therefore, your email off-topic on these lists.

> Thomas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

