Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUAZOmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUAZOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:42:04 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:45188 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263762AbUAZOmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:42:01 -0500
Subject: Re: gcc 2.95.3
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Stef van der Made <svdmade@planet.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040124004848.C25466@flint.arm.linux.org.uk>
References: <20040123145048.B1082@beton.cybernet.src>
	 <20040123100035.73bee41f.jeremy@kerneltrap.org>
	 <20040123151340.B1130@beton.cybernet.src>
	 <001b01c3e1ca$26101f20$1e00000a@black>
	 <20040123163008.B1237@beton.cybernet.src>
	 <1074882836.20723.4.camel@minerva> <4011AC22.8050903@planet.nl>
	 <20040124004848.C25466@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1075128103.24024.64.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Mon, 26 Jan 2004 14:41:43 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-24 at 00:48 +0000, Russell King wrote:
> I suspect that the fs/jffs2/erase.c problem is not ARM-specific, though
> I'm no compiler expert.

I think it's been seen on MIPS too.

-- 
dwmw2

