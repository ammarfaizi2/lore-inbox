Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDAQBi>; Sun, 1 Apr 2001 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132521AbRDAQB3>; Sun, 1 Apr 2001 12:01:29 -0400
Received: from dsl-64-128-37-73.telocity.com ([64.128.37.73]:40965 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S132517AbRDAQBT>; Sun, 1 Apr 2001 12:01:19 -0400
Message-Id: <4.3.2.7.2.20010401115819.00b52340@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 01 Apr 2001 12:00:28 -0400
To: Mike Bennett <mbennett@ns1.cfcc.cc.fl.us>
From: David Relson <relson@osagesoftware.com>
Subject: Re: aic7xxx 6.1.8 for 2.2.19
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010401105412.G21419@cfcc.cc.fl.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:54 AM 4/1/01, Mike Bennett wrote:
>Was getting ready to compile 2.2.19 this AM and went to
>Justin's site to grab the latest aic7xxx driver.
>
>Unfortunately, he doesn't have a patch for 2.2.19 and the
>2.2.18 patch doesn't apply cleanly because the stock driver
>changed.
>
>It's a long story, but the short version is that the stock
>driver has always given me timeouts with heavy disk activity.
>Right now I'm using 6.0.8beta in 2.2.18 since Jan 12 and have
>not had a single timeout problem. Needless to say, I won't be
>upgrading kernels today.  Damn, now I've got no excuse for
>not mowing the lawn... :)

No excuse needed here in Ann Arbor, Michigan.  This morning lawn mowing is 
a non-issue.  It's snowing merrily - just like it was winter.


>Has anyone made a patch against 2.2.19 ?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

