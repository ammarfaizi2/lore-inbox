Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWGIUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWGIUdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbWGIUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:33:13 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161125AbWGIUdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:33:12 -0400
Date: Sun, 9 Jul 2006 22:33:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revert "ACPI: dock driver"
Message-ID: <20060709203310.GP13938@stusta.de>
References: <200607091559.k69Fx2h0029447@hera.kernel.org> <44B15BCB.5000306@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B15BCB.5000306@vc.cvut.cz>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 09:40:59PM +0200, Petr Vandrovec wrote:
> Linux Kernel Mailing List wrote:
> >commit 953969ddf5b049361ed1e8471cc43dc4134d2a6f
> >tree e4b84effa78a7e34d516142ee8ad1441906e33de
> >parent b862f3b099f3ea672c7438c0b282ce8201d39dfc
> >author Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 
> >-0700
> >committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 09 Jul 2006 22:47:46 
> >-0700
> >
> >Revert "ACPI: dock driver"
> >
> >This reverts commit a5e1b94008f2a96abf4a0c0371a55a56b320c13e.
> >
> >Adrian Bunk points out that it has build errors, and apparently no
> >maintenance. Throw it out.
> 
> Erm, what do I miss?  Code certainly builds, just before that checkin.
>...

Not with all .config's:

http://lkml.org/lkml/2006/6/25/126
http://lkml.org/lkml/2006/6/25/134
 
> 						Thanks,
> 							Petr Vandrovec

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

