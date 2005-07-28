Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVG1UoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVG1UoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVG1Unf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:43:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262216AbVG1Umk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:42:40 -0400
Date: Thu, 28 Jul 2005 22:42:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Radoslaw AstralStorm Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3 question
Message-ID: <20050728204238.GC4790@stusta.de>
References: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl> <20050728105551.57f3183c.akpm@osdl.org> <20050728203133.0a03dbda.astralstorm@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728203133.0a03dbda.astralstorm@gorzow.mm.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 08:31:33PM +0200, Radoslaw AstralStorm Szkodzinski wrote:
> On Thu, 28 Jul 2005 10:55:51 -0700
> Andrew Morton <akpm@osdl.org> wrote:
>...
> > There are always glitches, I'm afraid.
> 
> But there could be less build breakers at least.

The -mm kernels are the result of mixing the latest developments from a 
dozen subsystem trees with a few hundred random patches from 
linux-kernel resulting in the most unstable kernel available. [1]

I'm surprised that you are that much concerned about compile errors when 
using a kernel that might regularly exchange the contents of /dev/hda 
and /dev/null .

cu
Adrian

[1] that's a bit exaggerated and not meant against Andrew

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

