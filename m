Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265643AbSKAGnU>; Fri, 1 Nov 2002 01:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265644AbSKAGnT>; Fri, 1 Nov 2002 01:43:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265643AbSKAGnT>; Fri, 1 Nov 2002 01:43:19 -0500
Date: Thu, 31 Oct 2002 22:36:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.3.96.1021101000448.23822B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0210312233190.5595-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Nov 2002, Bill Davidsen wrote:
> 
>   If you really believed the stuff you say you'd put it in and promise to
> take it out if people didn't find it useful or there were inherent
> limitations.

This never works. Be honest. Nobody takes out features, they are stuck 
once they get in. Which is exactly why my job is to say "no", and why 
there is no "accepted unless proven bad". 

> It would probably take 10-30% off the time to a stable release.

Talk is cheap.

I've not seen a _single_ bug-report with a fix that attributed the
existing LKCD patches. I might be more impressed if I had. 

The basic issue is that we don't put patches in in the hope that they will
prove themselves later. Your argument is fundamentally flawed.

		Linus

