Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUHKTWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUHKTWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 15:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUHKTWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 15:22:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20702 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268185AbUHKTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 15:22:06 -0400
Date: Wed, 11 Aug 2004 21:21:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/seeq8005.c: small cleanups (fwd)
Message-ID: <20040811192159.GE26174@fs.tum.de>
References: <20040809215112.GE26174@fs.tum.de> <411A64AA.70902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411A64AA.70902@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 02:25:46PM -0400, Jeff Garzik wrote:
>...
> >-static const char version[] =
> >-	"seeq8005.c:v1.00 8/07/95 Hamish Coleman 
> >(hamish@zot.apana.org.au)\n";
>...
> >-	if (net_debug  &&  version_printed++ == 0)
> >-		printk(version);
>...
> This "small cleanup" appears to kill useful and working code.

I'd agree if this was a version number that was regularly updated.

But when is a 9 year old version tag useful?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

