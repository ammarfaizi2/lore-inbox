Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTLOQYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTLOQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:24:08 -0500
Received: from main.gmane.org ([80.91.224.249]:1740 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263769AbTLOQYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:24:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: RFC - tarball/patch server in BitKeeper
Date: Mon, 15 Dec 2003 19:24:02 +0300
Message-ID: <20031215192402.528ce066.vsu@altlinux.ru>
References: <20031214172156.GA16554@work.bitmover.com>
	<2259130000.1071469863@[10.10.2.4]>
	<20031215151126.3fe6e97a.vsu@altlinux.ru>
	<20031215132720.GX7308@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Newsreader: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Cc: bitkeeper-users@bitmover.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 08:27:20 -0500 Ben Collins wrote:

> On Mon, Dec 15, 2003 at 03:11:26PM +0300, Sergey Vlasov wrote:
> > I see another missing feature - there does not seem to be a way to
> > order the changesets by the order of merging them into the tree. E.g.
> > when you look at the linux-2.4 changesets, you will now find XFS all
> > over the place - even before 2.4.23, while it really has been merged
> > after 2.4.23.
> 
> You don't seem to understand how bitkeeper works then. Back when the XFS
> tree was cloned from the 2.4 tree, it began it's own "branch". Over time
> it has merged code from the 2.4 tree, and it's work has occured over
> this same time.
> 
> When XFS was merged back into the 2.4 tree, it retains all of that
> history in sort of a split road looking branch/merge.

Keeping that history is good. But the main 2.4 branch also has its own
history - and it shows that there were no XFS code in that branch up
to and including 2.4.23.

There does not seem to be a way to get this information - at least
through bkbits.net.

