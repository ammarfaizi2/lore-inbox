Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTCFAlD>; Wed, 5 Mar 2003 19:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTCFAlC>; Wed, 5 Mar 2003 19:41:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33810 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267476AbTCFAlC>; Wed, 5 Mar 2003 19:41:02 -0500
Date: Wed, 5 Mar 2003 19:44:14 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: "James H. Cloos Jr." <cloos@jhcloos.com>, ext2-devel@lists.sourceforge.net,
       ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ext3 htree brelse problems look to be fixed!
In-Reply-To: <20030305013347.F0C9CECEC3@mx12.arcor-online.net>
Message-ID: <Pine.LNX.3.96.1030305194231.20846B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Daniel Phillips wrote:

> On Wed 05 Mar 03 00:57, James H. Cloos Jr. wrote:
> > I beleive (with this patch) htree is now ready for prime time.
> 
> Good that it's working for you, but it's not quite the last issue.  There is 
> some apparent cache thrashing to track down, and I believe there's still an 
> outstanding NFS issue.  It's getting there, though.

Well, if that's the last issue causing corruption of one kind or another,
I would say that it's a huge step forward. Performance is desirable,
reliability is manditory.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

