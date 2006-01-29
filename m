Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWA2XPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWA2XPr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 18:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWA2XPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 18:15:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14085 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932069AbWA2XPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 18:15:46 -0500
Date: Mon, 30 Jan 2006 00:15:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060129231545.GY3777@stusta.de>
References: <1138466271.8770.77.camel@lade.trondhjem.org> <20060128165732.GA8633@hardeman.nu> <1138504829.8770.125.camel@lade.trondhjem.org> <20060129113320.GA21386@hardeman.nu> <1138552702.8711.12.camel@lade.trondhjem.org> <20060129211310.GA20118@hardeman.nu> <1138570100.8711.63.camel@lade.trondhjem.org> <20060129220217.GA21832@hardeman.nu> <1138572311.8711.84.camel@lade.trondhjem.org> <1BE90924-C4BF-4123-AF20-88655772C8BF@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1BE90924-C4BF-4123-AF20-88655772C8BF@mac.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 05:54:00PM -0500, Kyle Moffett wrote:
>...
> If we use this proposed in-kernel system, then I can give my  
> certificate/pubkey to the kernel code, and then my web browser, SSH,  
> and anything else can automatically use it to decrypt and sign data  
> without being able to directly access (and thus compromise) the key.   
> If I later notice what I think might be a rogue process, I can  
> instantly and globally revoke all access to that keypair.

Why do you need this in the kernel?

A userspace daemon could do exactly the same.

> Cheers,
> Kyle Moffett

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

