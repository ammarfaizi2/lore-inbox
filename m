Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVEDLur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVEDLur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 07:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEDLui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 07:50:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29709 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261627AbVEDLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 07:50:27 -0400
Date: Wed, 4 May 2005 13:50:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig files (first part)
Message-ID: <20050504115024.GM3592@stusta.de>
References: <20050503003400.GO3592@stusta.de> <Pine.LNX.4.61.0505031107120.996@scrub.home> <20050503092202.GC3592@stusta.de> <Pine.LNX.4.61.0505031202080.996@scrub.home> <20050503105743.GE3592@stusta.de> <Pine.LNX.4.61.0505031519310.996@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505031519310.996@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 03:47:46PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Tue, 3 May 2005, Adrian Bunk wrote:
> 
> > > So why exactly has to be removed? Is it ugly? Does it make Kconfig worse?
> > 
> > The ugly thing is that there are currently two different ways to express 
> > the same thing. It only causes confusion for people who think those 
> > different syntaxes had a different meaning.
> 
> Languages often have more than one way to express something, this is not 
> different.
> Early on there was some confusion about this from people writing new 
> Kconfig entries (not just reading existing ones), but this was became a 
> non-issue since it's documented now.
>...

Different ways for expressing the same thing is good for writers but bad 
for readers.

E.g. where to place opening braces in C is a religious issue. For the 
Linux kernel, CodingStyle sets the rules. And although I'd prefer to set 
them different, I have to admit that the consistency indide the kernel 
makes reading easier.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

