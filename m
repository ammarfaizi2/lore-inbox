Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136594AbREAICy>; Tue, 1 May 2001 04:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136592AbREAICn>; Tue, 1 May 2001 04:02:43 -0400
Received: from [203.143.19.4] ([203.143.19.4]:48145 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S136591AbREAICg>;
	Tue, 1 May 2001 04:02:36 -0400
Date: Mon, 30 Apr 2001 18:19:55 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: David Konerding <dek_ml@konerding.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: traceroute breaks with 2.4.4
In-Reply-To: <3AEC6A23.4844DC4C@konerding.com>
Message-ID: <Pine.LNX.4.21.0104301819300.359-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Isn't it "kernel-user netlink socket"?

Anuradha

On Sun, 29 Apr 2001, David Konerding wrote:

> David Konerding wrote:
> 
> > As far as I can tell, somewhere between 2.4.2 and 2.4.4, traceroute
> > stopped working.
> > I see the problem on RH7.x.  Regular kernel compile with near-defaults
> > for networking,
> > no firewalling is enabled.  Rebootiing to a similar config under 2.4.2
> > works OK.
> 
> OK, I'm unable to fix this by reverting to 2.4.2 using the same config as
> 2.4.2.
> However, an older compiled 2.4.2 worked, so I think I must have changed
> some configuration which affects it.  Can't for the life of me figure out what
> it is,
> tho'.
> 
> Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

