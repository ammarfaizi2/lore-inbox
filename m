Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbTLOS6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTLOS6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:58:46 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:57787 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263963AbTLOS6n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:58:43 -0500
Date: Mon, 15 Dec 2003 10:58:39 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215185839.GA8130@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Sergey Vlasov <vsu@altlinux.ru>,
	linux-kernel@vger.kernel.org
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru> <20031215183138.GJ6730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215183138.GJ6730@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 07:31:38PM +0100, Andrea Arcangeli wrote:
> you get the 2.4 branch linear history via bkcvs. Though there you lose
> all the granular xfs development changesets instead, the xfs merge
> becames a huge monolithic patch see below.  Either way or another you
> lose information compared to true BK. From my part I'm fine with the
> info provided in bkcvs, I'm only correcting Larry statement about him
> providing lots of way to get at the data in a interoperable protocol,
> he's only providing _partial_ data in a interoperable way. I'm stating
> facts, no whining intendend.

You can get at the full patch level granularity via BK/Web, on bkbits,
complete with checkin comments, diffs, whatever you want.  There isn't
any more information to give you that is not internal BK information
which is covered by trade secret.  We have every right to not provide
you with information about how BitKeeper works and we've already provided
the data in multiple ways.

- You have an open export of the data into bkcvs, this addressed the "I'm not
  using BK so I'm at a disadvantage" problem

- You have patch by patch access to the data at bkbits.net for all
  repositories, this addressed the "I want the fine granularity of
  individual patches" problem.

- I've offered up the tarball+patch update protocol to address the "I'm not
  using BK so I can't easily track the latest version of J Random tree"
  problem.

And you still think that your needs aren't being addressed and feel the
need to make the claim that there aren't enough ways to get at the data,
that we are only providing partial data.

Forgive me if I don't agree, I don't think any remotely reasonable person
would agree, and I am confident that there is not the slightest chance
that you can get a court to agree.  
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
