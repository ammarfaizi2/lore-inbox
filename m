Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVBJXT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVBJXT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVBJXT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:19:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57092 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261894AbVBJXTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:19:43 -0500
Date: Fri, 11 Feb 2005 00:19:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL 2.6] Update panic() comment.
Message-ID: <20050210231936.GM2958@stusta.de>
References: <20050202121912.GA4536@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202121912.GA4536@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 01:19:12PM +0100, Heiko Carstens wrote:
> [TRIVIAL 2.6] Update panic() comment.
> 
> panic() doesn't flush the filesystem cache anymore. The comment above the
> function still claims it does.
> 
> Thanks,
> Heiko
> 
> ===== panic.c 1.22 vs edited =====
> --- 1.22/kernel/panic.c	2004-11-08 03:16:06 +01:00
> +++ edited/panic.c	2005-02-02 12:25:21 +01:00
>...

Please send patches that apply with -p1.

In this case even more, since the kernel sources contain two panic.c 
files.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

