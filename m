Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbUBGAuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUBGAuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:50:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:12706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265295AbUBGAuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:50:01 -0500
Date: Fri, 6 Feb 2004 16:49:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: Elikster <elik@webspires.com>, Linux Kern <linux-kernel@vger.kernel.org>
Subject: Re: Linux Capabilities and Other Security Models Documentation?
Message-ID: <20040206164958.A27500@build.pdx.osdl.net>
References: <200402060351.i163ptpB010350@turing-police.cc.vt.edu> <584993969.20040205212714@webspires.com> <20040206044514.GB2655@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040206044514.GB2655@cse.unsw.EDU.AU>; from dsw@gelato.unsw.edu.au on Fri, Feb 06, 2004 at 03:45:14PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Darren Williams (dsw@gelato.unsw.edu.au) wrote:
> Hi Elikster
> 
> SELinux:
> www.nsa.gov/selinux/
> 
> Capabilities:
> According to
> http://www.hsc.fr/ressources/presentations/linux2000/linux2000-6.html.en
> these are obsolete.

The POSIX draft was withdrawn, however the code is still functional.
2.6 Capabilities are the same as earlier kernels from a black-box
perspective.  The internals are what changed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
