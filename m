Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbTLBVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLBVk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:40:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:429 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264388AbTLBVk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:40:26 -0500
Date: Tue, 2 Dec 2003 13:40:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ville Herva <vherva@twilight.cs.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202134018.A12116@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <20031202131311.GA10915@physik.tu-cottbus.de> <3FCC95BB.60205@wmich.edu> <20031202160136.GB10915@physik.tu-cottbus.de> <20031202160853.GB22608@gtf.org> <20031202201933.GE1524@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031202201933.GE1524@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Tue, Dec 02, 2003 at 10:19:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ville Herva (vherva@niksula.hut.fi) wrote:
> On Tue, Dec 02, 2003 at 11:08:53AM -0500, you [Jeff Garzik] wrote:
> > Bug fixes, security errata, and the like will always be OK for 2.4.  Just
> > like Alan continues to release new 2.2.x releases, when major bugs are
> > found.
> 
> Which btw invites the question: the recent brk() security fix was ported
> from 2.5 to 2.4, right? Any idea whether it applies to 2.2 (and 2.0), too?

2.2 and 2.0 look ok as they use do_mmap() which has proper checks.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
