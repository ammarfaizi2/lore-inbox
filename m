Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSLBS1B>; Mon, 2 Dec 2002 13:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSLBS1B>; Mon, 2 Dec 2002 13:27:01 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24339 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264749AbSLBS1A>; Mon, 2 Dec 2002 13:27:00 -0500
Date: Mon, 2 Dec 2002 13:33:05 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Romain Lievin <rlievin@free.fr>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: and next ?
In-Reply-To: <20021130230701.GA13307@free.fr>
Message-ID: <Pine.LNX.3.96.1021202132609.433B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Romain Lievin wrote:

> will be there a kernel after 2.4.20 ?
> 
> I would like to submit a patch for backporting the tipar char driver.

There were 2.0 releases until 2001, and three 2.2 releases this year
alone, I think you can assume that there will be releases for at least
another year.

Actually with all the problem reports and partial fixes for data loss on
journaling filesystems (or perhaps only ext3), I would expect another
release fairly soon.

Certainly if you submit a patch by the end of the year it would be soon
enough, although it still has to be accepted. I can't see any reason why
it wouldn't, although that doesn't mean much.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

