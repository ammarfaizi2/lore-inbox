Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWDRTFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDRTFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWDRTFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:05:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25352 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932284AbWDRTFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:05:30 -0400
Date: Tue, 18 Apr 2006 21:05:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, discuss@x86-64.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.
Message-ID: <20060418190528.GL11582@stusta.de>
References: <4444C0EA.mailKK411J5GA@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4444C0EA.mailKK411J5GA@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 12:35:22PM +0200, Andi Kleen wrote:
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
>...

NAK.

When submitting a patch that is the revert of a patch that went 
into Linus' tree just 8 days ago [1], I'd expect at least:
- a Cc to the people involved with the patch you are reverting
- a note that you are reverting a recent patch in your patch
  description
- an explanation why you disagree with the patch you are reverting

If you disagree with a patch, please speak up when it's submitted or 
discuss it after you've seen it in the tree. But don't play such silly
revert-and-hope-they-don't-notice-I've-reverted-it games.

cu
Adrian

[1] commit e39632faa0efbddc3aed4f8658f2fa0a8afa2717

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

