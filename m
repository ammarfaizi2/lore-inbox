Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUKCA1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUKCA1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUKCAXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:23:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35086 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262274AbUKBWnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:43:43 -0500
Date: Tue, 2 Nov 2004 22:43:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Serial updates
Message-ID: <20041102224329.B10969@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20041031175114.B17342@flint.arm.linux.org.uk> <1099368552.29693.434.camel@gaston> <1099369226.29689.441.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1099369226.29689.441.camel@gaston>; from benh@kernel.crashing.org on Tue, Nov 02, 2004 at 03:20:26PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 03:20:26PM +1100, Benjamin Herrenschmidt wrote:
> And here's another one that also fixes a little bug in the
> default console selection code ...

Thanks for testing Ben, applied.

akpm - do you want this set of serial changes to appear in one -mm
release before hitting Linus?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
