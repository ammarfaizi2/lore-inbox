Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbULZQCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbULZQCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbULZQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:02:18 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:45279 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261686AbULZQCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:02:13 -0500
Date: Sun, 26 Dec 2004 08:02:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041226160205.GB26574@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	M?ns Rullg?rd <mru@inprovide.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <20041226011222.GA1896@work.bitmover.com> <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x7jn5bbj1.fsf@inprovide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 11:26:42AM +0100, M?ns Rullg?rd wrote:
> I've been bitten by that one, as I occasionally work off-line.  Is
> there some way I can make BK renew the leases a week or so before they
> expire?

In theory, we do that already.  By you can always do a "bk lease renew"
and that will get you a new lease.  "bk lease show" will show you your
lease.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
