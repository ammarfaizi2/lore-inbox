Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVAJVZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVAJVZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVAJVW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:22:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55311 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262554AbVAJVL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:11:27 -0500
Date: Mon, 10 Jan 2005 21:11:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110211123.C10365@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050110184307.GB2903@stusta.de> <20050110190809.A10365@flint.arm.linux.org.uk> <20050110192120.GE2903@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050110192120.GE2903@stusta.de>; from bunk@stusta.de on Mon, Jan 10, 2005 at 08:21:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 08:21:20PM +0100, Adrian Bunk wrote:
> On Mon, Jan 10, 2005 at 07:08:10PM +0000, Russell King wrote:
> > I assume as you removed Pierre Ossman's email address as well that
> > you apply the same argument to peoples email addresses?
> 
> Yes.
> 
> ( BTW: It wasn't obvious to me that this s a personal address and not
>        a mailing list. )
> 
> > (Not that I'm endorsing SPF in any way - discussions about SPF are
> > *off topic* here.)
> 
> Agreed. I'm simply considering it important that all addresses in 
> maintainers are reachable for everyone.

That is a flawed reason.  There is no way to guarantee that all
addresses listed there are reachable for *everyone*, so I guess
that'll mean that you'll be removing all email addresses in that
file.

You might alternatively consider trying to resolve whatever issue
there is - maybe Pierre doesn't realise what he's (or his ISP) is
doing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
