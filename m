Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSKEEvG>; Mon, 4 Nov 2002 23:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264780AbSKEEvG>; Mon, 4 Nov 2002 23:51:06 -0500
Received: from almesberger.net ([63.105.73.239]:26633 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S264767AbSKEEvF>; Mon, 4 Nov 2002 23:51:05 -0500
Date: Tue, 5 Nov 2002 01:57:31 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
Message-ID: <20021105015731.F1407@almesberger.net>
References: <Pine.LNX.3.96.1021103082813.5197A-100000@gatekeeper.tmr.com> <3DC5DF14.34483A96@compuserve.com> <aq616a$9da$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq616a$9da$1@forge.intermeta.de>; from hps@intermeta.de on Mon, Nov 04, 2002 at 02:45:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:
> Good! This means, people debugging the code have actually to think and
> don't produce "turn on debugger, step here, there, patch a band aid,
> done" solutions you see with various other "commercial products"

Unfortunately, just making it hard doesn't guarantee that they
won't try anyway. If you're lucky, at least their band aid will
be so disgusting that you won't be fooled into thinking they
might be right.

But ultimately, it's an attitude problem. Even people who learn
about their bugs by source code reading may then produce a
shabby fix.

Hmm, I wonder if Linus has ever done any protocol design,
followed by validation. I always find the havoc a protocol
validator (e.g. Spin) wreaks a very instructive demonstration
of how much source code level "correctness" really buys you :-)
(Or what chances you'd stand of realizing what happened just
from an Oops.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
