Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269951AbUJHNI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269951AbUJHNI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUJHNI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:08:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17423 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269951AbUJHNIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:08:24 -0400
Date: Fri, 8 Oct 2004 15:07:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [patch] fix unterminated comment in asm-parisc/som.h
Message-ID: <20041008130752.GK5227@stusta.de>
References: <20041008124754.GH5227@stusta.de> <20041008125643.GP16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008125643.GP16153@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 01:56:43PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 08, 2004 at 02:47:55PM +0200, Adrian Bunk wrote:
> > 
> > The patch below fixes an unterminated comment in 
> > include/asm-parisc/som.h present in both 2.4 and 2.6 .
> > 
> > This bug was found using David A. Wheeler's 'SLOCCount'.
> 
> This file has already been deleted as it is unused.

Ah, this also explains why noone noted before...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

