Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbULZK0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbULZK0r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 05:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbULZK0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 05:26:47 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:3282 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261624AbULZK0p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 05:26:45 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lease.openlogging.org is unreachable
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
	<20041226011222.GA1896@work.bitmover.com>
	<20041226030957.GA8512@work.bitmover.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
In-Reply-To: <20041226030957.GA8512@work.bitmover.com> (Larry McVoy's
 message of "Sat, 25 Dec 2004 19:09:57 -0800")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Date: Sun, 26 Dec 2004 11:26:42 +0100
Message-ID: <yw1x7jn5bbj1.fsf@inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> The interesting thing is that the code already has a backup in it and I just
> checked that code path and it works.
>
> Has anyone else been shut down because of lease.openlogging.org being down
> and if so what version of BK were you running please?
>
> It is true that both servers are at our offices so if the network had been
> down you would have been out of luck.

I've been bitten by that one, as I occasionally work off-line.  Is
there some way I can make BK renew the leases a week or so before they
expire?

It would also be nice if a simple read-only 'get' were allowed without
a lease at all.

-- 
Måns Rullgård
mru@inprovide.com
