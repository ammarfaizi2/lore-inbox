Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSLJU5n>; Tue, 10 Dec 2002 15:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSLJU5n>; Tue, 10 Dec 2002 15:57:43 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:18186
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264938AbSLJU5m>; Tue, 10 Dec 2002 15:57:42 -0500
Subject: Re: [BENCHMARK] 2.5.51 with contest
From: Robert Love <rml@ufl.edu>
To: Stan Bubrouski <stan@ccs.neu.edu>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF64852.9030006@ccs.neu.edu>
References: <200212102245.19862.conman@kolivas.net>
	 <3DF621D0.6040505@ccs.neu.edu> <1039545941.1831.849.camel@phantasy>
	 <3DF64852.9030006@ccs.neu.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1039554327.846.1128.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 16:05:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 15:02, Stan Bubrouski wrote:

> I disagree, 2.4.20 is the current stable kernel, it would
> be nice to see how it compares to the current development,
> what's faster, what's not... from Con's previous results
> we can see that some things are indeed not as fast in 2.5.x
> as in 2.4.x.  It's just nice to be able to see the whole
> picture.  I often follow these threads for just this purpose.

Like I said, that may give users warm fuzzies or be helpful to marketing
folks but Con's benchmark is not really useful for _helping developers_
wrt comparing 2.4 vs 2.5.

A benchmark like AIM9, which is a bunch of micro-benchmarks, is useful
because we can say "look truncating a zero-length file is a lot slower
now".

But a contest result from 2.4 to 2.5 tells us what?  Especially since
lower times in contest may not even be bad.  Contest is invaluable for
testing one change vs. without.  In fact, I would venture to say Con's
work is a big reason why 2.5 has the fairness and interactive
performance it does.  But it is not so helpful to see changes since 2.4.

	Robert Love

