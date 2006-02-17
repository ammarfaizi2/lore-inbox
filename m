Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030645AbWBQQdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWBQQdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWBQQdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:33:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030649AbWBQQdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:33:23 -0500
Date: Fri, 17 Feb 2006 17:33:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jes Sorensen <jes@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] show "SN Devices" menu only if CONFIG_SGI_SN
Message-ID: <20060217163322.GH4422@stusta.de>
References: <20060217132245.GG4422@stusta.de> <yq08xsaxb0s.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq08xsaxb0s.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 10:25:39AM -0500, Jes Sorensen wrote:
> >>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:
> 
> Adrian> On architectures like i386, the "Multimedia Capabilities Port
> Adrian> drivers" menu is visible, but it can't be visited since it
> Adrian> contains nothing usable for CONFIG_SGI_SN=n.
> 
> Thats only a third of the patch, if you want to do that, you should
> remove the redundant SGI_SN checks below.
> 
> Like this.

Looks good.

> Jes
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

