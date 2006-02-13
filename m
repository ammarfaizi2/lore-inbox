Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWBMSm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWBMSm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWBMSm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:42:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:33799 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932420AbWBMSm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:42:57 -0500
Date: Mon, 13 Feb 2006 19:42:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213184255.GB3588@stusta.de>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de> <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org> <20060213174658.GC23048@redhat.com> <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org> <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org> <20060213182712.GA32350@redhat.com> <Pine.LNX.4.64.0602131032240.3691@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602131032240.3691@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 10:33:24AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 13 Feb 2006, Dave Jones wrote:
> > 
> > r300 is unlike the other chips though.
> > Adding that ID on its own doesn't make any sense, as the rest of the
> > radeon driver won't have a clue how to drive the new hardware.
> 
> There were RV350 entries in the drm_pciids file before 2.6.15 as far as I 
> can tell..

The entry Dave's patch removes is the only RV350 entry for an RV370.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

