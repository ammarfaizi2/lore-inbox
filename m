Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbUAZD1f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265488AbUAZD1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:27:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49375 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265479AbUAZD1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:27:33 -0500
Date: Mon, 26 Jan 2004 04:27:15 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andi Kleen <ak@muc.de>
Cc: Fabio Coatti <cova@ferrara.linux.it>, Andrew Morton <akpm@osdl.org>,
       eric@cisu.net, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040126032714.GB513@fs.tum.de>
References: <200401232253.08552.eric@cisu.net> <200401252221.01679.cova@ferrara.linux.it> <20040125214653.GB28576@colin2.muc.de> <200401252308.33005.cova@ferrara.linux.it> <20040125221304.GD28576@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125221304.GD28576@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 11:13:04PM +0100, Andi Kleen wrote:
> On Sun, Jan 25, 2004 at 11:08:33PM +0100, Fabio Coatti wrote:
> > > does official 2.6.2rc1 (not mm) with -funit-at-a-time enabled in the
> > > Makefile work?
> > 
> > Yes. 
> 
> Ok, then it is something in -mm*. I would suspect the new weird CPU
> configuration stuff. Can you double check you configured your CPU correctly? 
>...

The .config's were already sent, and they seemed to be correct.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

