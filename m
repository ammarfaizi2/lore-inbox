Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULZU05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULZU05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 15:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbULZU05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 15:26:57 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:17299 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S261159AbULZU04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 15:26:56 -0500
In-Reply-To: <20041226181837.GA28786@work.bitmover.com>
References: <200412250121_MC3-1-91AF-7FBB@compuserve.com> <20041226011222.GA1896@work.bitmover.com> <20041226030957.GA8512@work.bitmover.com> <yw1x7jn5bbj1.fsf@inprovide.com> <20041226160205.GB26574@work.bitmover.com> <yw1xmzw19bnn.fsf@inprovide.com> <20041226181837.GA28786@work.bitmover.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7B84F00C-577C-11D9-BCB8-000A95E3BCE4@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       M?ns Rullg?rd <mru@inprovide.com>
From: Martin Dalecki <martin@dalecki.de>
Subject: Re: lease.openlogging.org is unreachable
Date: Sun, 26 Dec 2004 21:26:54 +0100
To: Larry McVoy <lm@bitmover.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-26, at 19:18, Larry McVoy wrote:
>
> The other answer, which I'm happy to consider, is to come up with a 
> unique
> id on a per host basis and use that for the leases.  That's not a fun 
> task,
> does anyone have code (BSD license please) which does that?

Nothing even moderately portable like this exists. The best 
approximation
imaginable would be starting to collect MAC address id's... But thats 
of corse
the wrong protocol layer.

