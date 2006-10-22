Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWJVWTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWJVWTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJVWTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:19:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:7063 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750767AbWJVWTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:19:19 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: make pdfdocs broken in 2.6.19rc2 and needs fixes
Date: Mon, 23 Oct 2006 00:17:42 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
References: <200610222347.42418.ak@suse.de> <453BEA00.4000601@garzik.org>
In-Reply-To: <453BEA00.4000601@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230017.42614.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 00:00, Jeff Garzik wrote:
> Andi Kleen wrote:
> > When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
> > messages and  then some corrupted PDFs in the end.
> > 
> > Fixing that (I suppose it will just need comment fixes and
> > should not affect the code) should be a relatively easy task for 
> > a newbie and  would be useful for the 2.6.19 release.
> 
> What userland were you using?  Unfortunately with 'make *docs' that matters.
> 
> Unquestionably, there is breakage regardless of distro.

SUSE 10.0 userland. The errors look like pretty generic TeX errors
though and that tends to not change very often.

-Andi

