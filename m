Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTIYUTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTIYUTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 16:19:40 -0400
Received: from [209.195.52.120] ([209.195.52.120]:21467 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261885AbTIYUTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 16:19:32 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 25 Sep 2003 13:15:38 -0700 (PDT)
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030925182921.GA18749@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0309251313560.7784@dlang.diginsite.com>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
 <20030925122838.A16288@discworld.dyndns.org> <20030925182921.GA18749@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry, have you or could you publish the BK->?? export code?, This way
even if you do not host the exported stuff it would be trivial for a
person who is willing to use bk to setup a server to mirror any 'bk-only'
project.

David Lang


On Thu, 25 Sep 2003, Larry McVoy wrote:

> Date: Thu, 25 Sep 2003 11:29:22 -0700
> From: Larry McVoy <lm@bitmover.com>
> To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
>      Larry McVoy <lm@bitmover.com>
> Subject: Re: log-buf-len dynamic
>
> On Thu, Sep 25, 2003 at 12:28:38PM -0600, Charles Cazabon wrote:
> > Perhaps BitMover could release a client that can't do anything but keep a
> > local (unmodified) tree in sync with a public repository tree, so that the
> > "politically objectionable" (to some) parts of the BK license don't matter.
> >
> > In an idea world, this read-only client could be released in source form, but
> > I'm under no illusions there :).
>
> People ask us for this all the time and it just highlights the point that
> people don't understand how BK works.  It isn't client server, it's peer
> to peer, every so-called client has to have all the smarts built in that
> the so-called server has.
>
> There isn't any way to release a stripped down version that makes sense.
> If there was, we would.
> --
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
