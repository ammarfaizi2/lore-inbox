Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVAYRMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVAYRMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVAYRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:11:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36691
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262026AbVAYRIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:08:41 -0500
Date: Tue, 25 Jan 2005 18:08:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: CVSps@dm.cobite.com, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: kernel CVS troubles with cvsps
Message-ID: <20050125170835.GZ7587@dualathlon.random>
References: <20050125164203.GY7587@dualathlon.random> <20050125165807.GA20828@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125165807.GA20828@nevyn.them.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:58:07AM -0500, Daniel Jacobowitz wrote:
> FYI, I haven't tried using cvsps on the kernel CVS, but I used to use it on
> GCC - and it fell down like this on a constant basis.

Interesting, for me it always worked fine on the kernel until last
month.

> You might want to take a look at 'xcvs', by Jun Sun.  It's much more
> reliable and does everything I used to use cvsps for.  And generally
> faster too.

I'll check it, thanks for the info.
