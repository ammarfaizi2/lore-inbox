Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVAJTkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVAJTkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVAJTjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:39:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262501AbVAJTVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:21:32 -0500
Date: Mon, 10 Jan 2005 20:21:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110192120.GE2903@stusta.de>
References: <20050110184307.GB2903@stusta.de> <20050110190809.A10365@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110190809.A10365@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 07:08:10PM +0000, Russell King wrote:
> On Mon, Jan 10, 2005 at 07:43:07PM +0100, Adrian Bunk wrote:
> > <drzeus-wbsd@drzeus.cx>:
> > Connected to 213.115.189.212 but sender was rejected.
> > Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not 
> > pass the
> > +Sender Policy Framework
> > I'm not going to try again; this message has been in the queue too long.
> > 
> > IMHO lists rejecting emails based on some non-standard extension don't 
> > belong into MAINTAINERS.
> 
> I assume as you removed Pierre Ossman's email address as well that
> you apply the same argument to peoples email addresses?

Yes.

( BTW: It wasn't obvious to me that this s a personal address and not
       a mailing list. )

> (Not that I'm endorsing SPF in any way - discussions about SPF are
> *off topic* here.)

Agreed. I'm simply considering it important that all addresses in 
maintainers are reachable for everyone.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

