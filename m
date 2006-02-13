Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWBMTJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWBMTJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWBMTJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:09:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63751 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964801AbWBMTJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:09:09 -0500
Date: Mon, 13 Feb 2006 20:09:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213190907.GD3588@stusta.de>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org> <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org> <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213183445.GA3588@stusta.de> <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:50:52AM -0800, Linus Torvalds wrote:
>...
> I just worry whether (a) the other added PCI ID's are any good for that 
> core and (b) whether the bug was really introduced with some of the other 
> changes. I admit that (b) is pretty unlikely, but it would be good to 
> test.
>...

The one thing I have not yet been proven wrong for is that this PCI id 
is the only one we have in this driver for an RV370.

Perhaps someone will be able to prove this wrong, too, ;-) but otherwise 
it would be a good explanation why exactly this one is causing problems.

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

