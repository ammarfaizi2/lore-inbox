Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbUL1FVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUL1FVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUL1FTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:19:44 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:38220 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262072AbUL1FTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:19:30 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, akpm@osdl.org, torvalds@osdl.org,
       netdev@oss.sgi.com
X-Message-Flag: Warning: May contain useful information
References: <200412192214.KlDxQ7icOmxHYIf0@topspin.com>
	<20041220.153845.70996857.yoshfuji@linux-ipv6.org>
	<20041227210007.398734cd.davem@davemloft.net>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 27 Dec 2004 21:19:26 -0800
In-Reply-To: <20041227210007.398734cd.davem@davemloft.net> (David S.
 Miller's message of "Mon, 27 Dec 2004 21:00:07 -0800")
Message-ID: <52k6r3j8yp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][v4][0/24] Second InfiniBand merge candidate patch set
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Dec 2004 05:19:26.0939 (UTC) FILETIME=[CCDE4AB0:01C4EC9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> If Roland can resubmit his patch queue to me with the fixes
    David> folks have recommended to him, I can start merging this
    David> stuff in.

Andrew has indicated to me that he has merged the whole InfiniBand
patch into -mm now.

Dave, did you want to handle the entire merge of the whole IB stack,
or just the net/ parts, which are pretty trivial and stand alone,
since AF_INFINIBAND is already defined in the tree?

I'm happy to do whatever it takes to get IB merged as expeditiously as
possible so Dave & Andrew, please let me know what seems easiest and
best to you.

Thanks,
  Roland
