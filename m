Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTLOPm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLOPm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:42:29 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:9654 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263679AbTLOPm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:42:27 -0500
Date: Mon, 15 Dec 2003 07:42:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       bitkeeper-users@bitmover.com
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215154226.GD16554@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
	bitkeeper-users@bitmover.com
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2259130000.1071469863@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 10:31:04PM -0800, Martin J. Bligh wrote:
> One thing that I've wished for in the past which looks like it *might*
> be trivial to do is to grab a raw version of the patch you already
> put out in HTML format, eg if I surf down changesets and get to a page
> like this:
> 
> http://linus.bkbits.net:8080/linux-2.5/patch@1.1522?nav=index.html|ChangeSet@-2w|cset@1.1522

We can do that and we will, it's just not hit the top of the priority list.
Given past discussions on this list I had thought there was a strong need 
for a way to trivially track any BK tree without BK, maybe I misunderstood
what was being asked.

There isn't any reason we can't do both.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
