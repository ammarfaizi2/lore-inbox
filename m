Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVIBWYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVIBWYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVIBWYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:24:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1548 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751374AbVIBWYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:24:31 -0400
Date: Sat, 3 Sep 2005 00:24:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ollie Wild <aaw@rincewind.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-sh csum_partial_copy_generic() bugfix
Message-ID: <20050902222421.GA3657@stusta.de>
References: <430E0697.5000503@rincewind.tv> <43188B60.6030501@rincewind.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43188B60.6030501@rincewind.tv>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 10:26:56AM -0700, Ollie Wild wrote:

> It's been about a week since I posted this bug report, and I haven't 
> gotten any responses.  Is there someone I should contact directly?  Can 
> someone please point me in the right direction?

The MAINTAINERS file in the kernel sources contains the following 
contact information for the sh port:

SUPERH (sh)
P:      Paul Mundt
M:      lethal@linux-sh.org
P:      Kazumoto Kojima
M:      kkojima@rr.iij4u.or.jp
L:      linux-sh@m17n.org
W:      http://www.linux-sh.org
W:      http://www.m17n.org/linux-sh/
W:      http://www.rr.iij4u.or.jp/~kkojima/linux-sh4.html
S:      Maintained

> Thanks,
> Ollie
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

