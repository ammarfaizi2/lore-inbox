Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSHGDCk>; Tue, 6 Aug 2002 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316712AbSHGDCk>; Tue, 6 Aug 2002 23:02:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20752 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316695AbSHGDCk>; Tue, 6 Aug 2002 23:02:40 -0400
Date: Tue, 6 Aug 2002 23:00:18 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: rwhron@earthlink.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <20020806043648.GA23256@rushmore>
Message-ID: <Pine.LNX.3.96.1020806225736.9964A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002 rwhron@earthlink.net wrote:

> > I sort of hoped it would be better in performance, not
> > increasingly worse.
> 
> There were a lot of improvements during the 2.4.19-pre series on 
> several I/O benchmarks.  Comparing 2.4.18 to 2.4.19 on a quad xeon. 
> Here are a few of the big changes (average of 5 runs):

Clearly, I may not have been clear that I expected 2.5.xx to be better
than 2.4.xx. That may have been an artifact of tuning one kernel or the
other, I'm waiting to get clarification on that.
 
> 300% drop in cpu usage on ext3 for tiobench seq reads

??? I hope you mean 67% drop.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

