Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSANQqN>; Mon, 14 Jan 2002 11:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287705AbSANQqC>; Mon, 14 Jan 2002 11:46:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S287626AbSANQot>;
	Mon, 14 Jan 2002 11:44:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 17:40:51 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020113193700.17441G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QAAG-0000mo-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 01:46 am, Bill Davidsen wrote:
> Finally, I doubt that any of this will address my biggest problem with
> Linux, which is that as memory gets cheap a program doing significant disk
> writing can get buffers VERY full (perhaps a while CD worth) before the
> kernel decides to do the write, at which point the system becomes
> non-responsive for seconds at a time while the disk light comes on and
> stays on.  That's another problem, and I did play with some patches this
> weekend without making myself really happy :-( Another topic,
> unfortunately.

Patience, the problem is understood and there will be a fix in the 2.5 
timeframe.

--
Daniel
