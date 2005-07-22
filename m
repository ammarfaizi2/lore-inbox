Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVGVUPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVGVUPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVGVUPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:15:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43529 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262157AbVGVUPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:15:07 -0400
Date: Fri, 22 Jul 2005 22:15:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel optimization
Message-ID: <20050722201503.GN3160@stusta.de>
References: <42E14134.1040804@yahoo.co.uk> <Pine.LNX.4.62.0507221250450.23492@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507221250450.23492@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 12:52:22PM -0700, David Lang wrote:

> This is a airly frequent question
> 
> the short answer is 'don't try'
> 
> the longer answer is that all the additional optimization options that are 
> part of O3+ are considered individually and if they make sense for the 
> kernel they are explicitly enabled (in some cases the optimizations need 
> to be explicitly turned off for proper functionality of the kernel under 
> all versions of GCC)

As far as I can see, none of the additional optimizations with -O3 is 
enabled in the kernel.

> David Lang

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

