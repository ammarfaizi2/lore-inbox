Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbULZVlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbULZVlh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 16:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbULZVlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 16:41:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27545 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261170AbULZVlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 16:41:36 -0500
Subject: Re: lease.openlogging.org is unreachable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: M?ns Rullg?rd <mru@inprovide.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226181837.GA28786@work.bitmover.com>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com>
	 <20041226011222.GA1896@work.bitmover.com>
	 <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com>
	 <20041226160205.GB26574@work.bitmover.com> <yw1xmzw19bnn.fsf@inprovide.com>
	 <20041226181837.GA28786@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104093456.16487.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 20:37:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 18:18, Larry McVoy wrote:
> The other answer, which I'm happy to consider, is to come up with a unique
> id on a per host basis and use that for the leases.  That's not a fun task,
> does anyone have code (BSD license please) which does that?

libuuid does that on straight statistical probability - what properties
do you want your id to have ?

