Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULZDKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULZDKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 22:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbULZDKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 22:10:10 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:30170 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261606AbULZDKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 22:10:05 -0500
Date: Sat, 25 Dec 2004 19:09:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: Chuck Ebbert <76306.1226@compuserve.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: lease.openlogging.org is unreachable
Message-ID: <20041226030957.GA8512@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <20041226011222.GA1896@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226011222.GA1896@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The interesting thing is that the code already has a backup in it and I just
checked that code path and it works.

Has anyone else been shut down because of lease.openlogging.org being down
and if so what version of BK were you running please?

It is true that both servers are at our offices so if the network had been
down you would have been out of luck.  We'll create some more backups and
scatter them around the US, that's no problem.  But if the logic in the 
code to get them is busted then we need to fix that.

Things should be stabilized now, the machine went up and down a few times
after my last "it's OK mail", it turned out we had a dieing ethernet card;
it's been replaced and we seem stable now.  
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
