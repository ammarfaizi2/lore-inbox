Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbSLEQ4j>; Thu, 5 Dec 2002 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbSLEQ4i>; Thu, 5 Dec 2002 11:56:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59400 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267353AbSLEQ4C>; Thu, 5 Dec 2002 11:56:02 -0500
Date: Thu, 5 Dec 2002 12:01:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Erich Focht <efocht@ess.nec.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: per cpu time statistics
In-Reply-To: <20021205111443.GA18600@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1021205120007.18090B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, William Lee Irwin III wrote:

> And so I feel we are all in harmony; the scheduler statistics are in
> fact valuable on all platforms, it's just an question of basic "should
> this overhead be required or optional?"

Unless there's a downside, optional. While I might want to instrument a
kernel to follow a problem, I see no gain for most people, regardless of
number of processors.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

