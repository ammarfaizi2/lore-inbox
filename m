Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTBOVrA>; Sat, 15 Feb 2003 16:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTBOVrA>; Sat, 15 Feb 2003 16:47:00 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34958 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265305AbTBOVq7>; Sat, 15 Feb 2003 16:46:59 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 15 Feb 2003 14:04:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030215215259.GA22512@work.bitmover.com>
Message-ID: <Pine.LNX.4.50.0302151402070.1891-100000@blue1.dev.mcafeelabs.com>
References: <20030214235724.GA24139@work.bitmover.com>
 <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home>
 <20030215181211.GA12315@work.bitmover.com>
 <Pine.LNX.4.50.0302151353180.1891-100000@blue1.dev.mcafeelabs.com>
 <20030215215259.GA22512@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Larry McVoy wrote:

> On Sat, Feb 15, 2003 at 01:56:02PM -0800, Davide Libenzi wrote:
> > Larry, I already said this and maybe you missed it ( or maybe not ).
> > What about having a GPLed ( or whatever other license ), read-only BK
> > available for the ones that simply need to fetch stuff from BK
> > repositories ? You don't have to maintain another repository for
> > compatibility, and also you enforce BK usage.
>
> We're not going to expose the network protocol.  For two reasons:
>     - it works really well (we're proud of this)
>     - it is really ugly (we're not proud of this :)
>
> A read only client isn't read only, it has to be read/write to update the
> out of date copy.

I was meaning read-only for the repository point of view. Ok, you don't
need to give away the protocol. You don't even have to give away source
code. Why don't you choose a binary license that removes things that ppl
are against of here ?




- Davide

