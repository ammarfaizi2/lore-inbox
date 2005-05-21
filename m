Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVEUWrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVEUWrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 18:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEUWrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 18:47:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34568 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261676AbVEUWrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 18:47:41 -0400
Date: Sun, 22 May 2005 00:47:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
Message-ID: <20050521224740.GJ4489@stusta.de>
References: <20050521001925.GQ5112@stusta.de> <200505210045.j4L0j8qO029162@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505210045.j4L0j8qO029162@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 08:45:08PM -0400, Horst von Brand wrote:
> Adrian Bunk <bunk@stusta.de> said:
> > Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> > obsolete.
> > 
> > It seems to be time to remove it.
> 
> [...]
> 
> > -          The raw driver is deprecated and may be removed from 2.7
> > -          kernels.  Applications should simply open the device (eg /dev/hda1)
> > -          with the O_DIRECT flag.
> 
> To me, this sounds like a promise to keep it around for 2.6 at least...

With the current development model, 2.7 is a synonym for 2.6.12 ...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

