Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVKGQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVKGQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVKGQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:16:25 -0500
Received: from systemlinux.org ([83.151.29.59]:25509 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S964857AbVKGQQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:16:25 -0500
Date: Mon, 7 Nov 2005 17:16:05 +0100
From: Andre Noll <maan@systemlinux.org>
To: Neil Brown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: BUG: soft lockup detected on CPU#0! (linux-2.6.14)
Message-ID: <20051107161605.GH26862@skl-net.de>
References: <20051106193142.GD26862@skl-net.de> <17262.31781.497775.640424@cse.unsw.edu.au> <20051106225138.GF26862@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106225138.GF26862@skl-net.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:51, Andre Noll wrote:
> > The following patch might fix it.  Please let me know the result.
> 
> Patch applied and rebooted. The box currently compiles glibc and
> firefox in parallel. No problems so far.

Just want to confirm that your patch indeed fixed the problem. I
can't reproduce the bug message any more.

Thanks again
Andre
-- 
Jesus not only saves, he also frequently makes backups
