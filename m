Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUBKQOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265896AbUBKQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:14:00 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:8836 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S265877AbUBKQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:13:59 -0500
Date: Wed, 11 Feb 2004 17:13:58 +0100
From: Sander <sander@humilis.net>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040211161358.GA11564@favonius>
Reply-To: sander@humilis.net
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402111523.i1BFNnOq020225@work.bitmover.com>
X-Uptime: 18:48:56 up 21:01, 12 users,  load average: 0.99, 0.97, 0.96
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote (ao):
> We're moving openlogging back to our offices and I'm experimenting
> with filesystems to see what gives the best performance for BK usage.
> Reiserfs looks pretty good and I'm wondering if anyone knows any
> reasons that we shouldn't use it for bkbits.net. Also, would it help
> if the journal was on a different disk? Most of the bkbits traffic is
> read so I doubt it.
> 
> Please cc me, I'm not on the list.

I've cc'ed the Reiserfs mailinglist.

IME Reiserfs is a fast and stable fs. If you have the time to benchmark
ext3, reiserfs, jfs and xfs (and ..) with bk then you would know first
hand which fs is best for you. It might be worth the time.

With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
