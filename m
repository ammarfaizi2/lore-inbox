Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbULZQAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbULZQAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULZQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:00:42 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:40671 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261685AbULZQA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:00:28 -0500
Date: Sun, 26 Dec 2004 08:00:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkcvs seems to have stale data [was Re: lease.openlogging.org is unreachable]
Message-ID: <20041226160016.GA26574@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Pavel Machek <pavel@ucw.cz>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <1103977484.22653.11.camel@localhost.localdomain> <20041226011545.GB1896@work.bitmover.com> <20041226122251.GB1590@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226122251.GB1590@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 01:22:51PM +0100, Pavel Machek wrote:
> Is something wrong with bkcvs? 2.6.10 was released 40 hours ago, but I
> still see -rc3 when I update... I'm doing

There is nothing wrong on our end, the conversion happened and was pushed
to master.kernel.org about 30 hours ago as part of the normal nightly update.

I logged into to master.kernel.org and checked:

lm@hera:/pub/scm/linux/kernel/bkcvs/linux-2.5(0)$ grep v2.6.10 ChangeSet,v
        v2_6_10:1.24782
	v2_6_10-rc3:1.24616
	v2_6_10-rc2:1.24188
	v2_6_10-rc1:1.23259
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
