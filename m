Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVBXGdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVBXGdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVBXGcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:32:07 -0500
Received: from waste.org ([216.27.176.166]:41148 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261872AbVBXG3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:29:14 -0500
Date: Wed, 23 Feb 2005 22:29:08 -0800
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc5
Message-ID: <20050224062908.GJ3163@waste.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 08:18:08PM -0800, Linus Torvalds wrote:
> 
> 
> Hey, I hoped -rc4 was the last one, but we had some laptop resource
> conflicts, various ppc TLB flush issues, some possible stack overflows in
> networking and a number of other details warranting a quick -rc5 before
> the final 2.6.11.
> 
> This time it's really supposed to be a quickie, so people who can, please 
> check it out, and we'll make the real 2.6.11 asap.
> 
> Mostly pretty small changes (the largest is a new SATA driver that crept
> in, our bad). But worth another quick round.

Very small.

[   ] patch-2.6.11-rc5.bz2               23-Feb-2005 20:20   14   
[   ] patch-2.6.11-rc5.bz2.sign          23-Feb-2005 20:20  248   
[   ] patch-2.6.11-rc5.gz                23-Feb-2005 20:20   37   
[   ] patch-2.6.11-rc5.gz.sign           23-Feb-2005 20:20  248   
[   ] patch-2.6.11-rc5.sign              23-Feb-2005 20:20  248   

Seems to have passed the gpg signature test on my end.

-- 
Mathematics is the supreme nostalgia of our time.
