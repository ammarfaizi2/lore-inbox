Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbSLaCUk>; Mon, 30 Dec 2002 21:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSLaCUk>; Mon, 30 Dec 2002 21:20:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49668 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267138AbSLaCUj>; Mon, 30 Dec 2002 21:20:39 -0500
Date: Mon, 30 Dec 2002 21:27:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.53 : modules_install warnings 
In-Reply-To: <20021229062833.09C3F2C07F@lists.samba.org>
Message-ID: <Pine.LNX.3.96.1021230212600.8353B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0212281758230.839-100000@linux-dev> you write:
> > Hello all,
> >   I received the following warnings while a 'make modules_install'. It 
> > looks like there are a few more locking changes that need to be made. :)
> 
> This is SMP, right?  Those warnings are perfectly correct (yes, those
> files need updating).

Any guess when you'll get them fixed?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

