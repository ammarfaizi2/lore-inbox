Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbUKJB7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUKJB7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbUKJB7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:59:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37391 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261819AbUKJB5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:57:46 -0500
Date: Wed, 10 Nov 2004 02:57:11 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding?
Message-ID: <20041110015711.GD4089@stusta.de>
References: <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de> <20041108183449.GC15077@stusta.de> <20041108190130.GA2564@wotan.suse.de> <20041108233806.GM15077@stusta.de> <20041109050107.GA5328@wotan.suse.de> <20041110014516.GC4089@stusta.de> <Pine.LNX.4.58.0411091750480.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411091750480.2301@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 05:51:41PM -0800, Linus Torvalds wrote:
> 
> On Wed, 10 Nov 2004, Adrian Bunk wrote:
> > 
> > I'm open for examples why this actually doesn't work, but after my 
> > (limited) testin I'd suggest the patch below for inclusion in the next 
> > -mm.
> 
> When was -ffreestanding introduced? Iow, it might not work with all 
> compiler versions.. Apart from that, I think it makes sense. 

It's supported in gcc 2.95 (which is the oldest compiler supported by 
kernel 2.6).

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

