Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSGARzP>; Mon, 1 Jul 2002 13:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSGARzO>; Mon, 1 Jul 2002 13:55:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55567 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316043AbSGARzO>; Mon, 1 Jul 2002 13:55:14 -0400
Date: Mon, 1 Jul 2002 13:52:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OKS] O(1) scheduler in 2.4
Message-ID: <Pine.LNX.3.96.1020701134937.23820A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the issue? The most popular trees have been using it without issue
for six months or so, and I know of no cases of bad behaviour. I know
there are people who don't believe in the preempt patch, but the new
scheduler seems to work better under both desktop and server load.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

