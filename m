Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269781AbUICVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269781AbUICVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUICVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:02:57 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:25436 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269781AbUICVBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:01:43 -0400
To: "David S. Miller" <davem@davemloft.net>
Cc: Michael.Waychison@Sun.COM, plars@linuxtestproject.org,
       Brian.Somers@Sun.COM, linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
X-Message-Flag: Warning: May contain useful information
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
	<20040816143824.15238e42.davem@redhat.com> <412CD101.4050406@sun.com>
	<20040825120831.55a20c57.davem@redhat.com> <412CF0E9.2010903@sun.com>
	<20040825175805.6807014c.davem@redhat.com> <412DC055.4070401@sun.com>
	<20040830161126.585a6b62.davem@davemloft.net>
	<1094238777.9913.278.camel@plars.austin.ibm.com>
	<4138C3DD.1060005@sun.com> <52acw7rtrw.fsf@topspin.com>
	<20040903133059.483e98a0.davem@davemloft.net>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Sep 2004 13:40:37 -0700
In-Reply-To: <20040903133059.483e98a0.davem@davemloft.net> (David S.
 Miller's message of "Fri, 3 Sep 2004 13:30:59 -0700")
Message-ID: <521xhjrsqi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Sep 2004 20:40:37.0795 (UTC) FILETIME=[44F29F30:01C491F6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> What do you mean by "latest"?  If it doesn't indicate
    David> driver version 3.9 it is not the latest.

"latest" == pulled last night.  (And yes it says version 3.9)

    David> Please make sure you try current sources, I've had nothing
    David> but positive reports for IBM blades from people actually
    David> using the correct current 3.9 driver.

I'll give it another try -- it could also be my chassis which is a
little flaky.

Thanks,
  Roland
