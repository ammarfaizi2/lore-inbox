Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSEFCgw>; Sun, 5 May 2002 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314079AbSEFCgv>; Sun, 5 May 2002 22:36:51 -0400
Received: from relay1.pair.com ([209.68.1.20]:18186 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S314078AbSEFCgt>;
	Sun, 5 May 2002 22:36:49 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CD5ECEE.E6C0B894@kegel.com>
Date: Sun, 05 May 2002 19:39:42 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
In-Reply-To: <3CD5CE35.3EF2B62E@kegel.com> <20020505.191422.11638807.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Dan Kegel <dank@kegel.com>
>    Date: Sun, 05 May 2002 17:28:37 -0700
> 
>    If I didn't need it for a demo this week (don't ask), I
>    wouldn't be messing with khttpd; I'd be switching to Tux.
> 
>    Seems like it's time to either fix khttpd or pull it from the kernel.
> 
> We are going to pull it from the kernel.
> 
> The only argument is whether to replace it with TUX or not.
> There is a lot of compelling evidence that suggests that
> reasonably close performance can be obtained in userspace.
> 
> I guess the decision on TUX is not a prerequisite for pulling
> khttpd though.

Right.  If khttpd had been pulled from 2.4.17, I would have
had weeks of warning that khttpd is unstable; instead, I learned
only when someone started doing his own stress testing, and I
have little time to fix it.  I say pull it from
2.4.19-pre9.  Marcello, put it out of its misery asap, please...
it'd time for khttpd to become a standalone patch again.
- Dan
