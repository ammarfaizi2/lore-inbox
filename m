Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289364AbSA1UaQ>; Mon, 28 Jan 2002 15:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSA1UaK>; Mon, 28 Jan 2002 15:30:10 -0500
Received: from nrg.org ([216.101.165.106]:28725 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S289386AbSA1U22>;
	Mon, 28 Jan 2002 15:28:28 -0500
Date: Mon, 28 Jan 2002 12:28:18 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alex Davis <alex14641@yahoo.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Don't use dbench for benchmarks
In-Reply-To: <Pine.LNX.3.95.1020128125322.17770A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.40.0201281221060.11816-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Richard B. Johnson wrote:
> > It sounds like you are describing the Aim Benchmark suite, which has
> > been used for years to compare unix system performancem, and was
> > recently released under the GPL by Caldera.
> >
> > See http://caldera.com/developers/community/contrib/aim.html
>
> That sounds good. Have you tried it? Does it seem to provide the
> kind of data that will show the effect of various trade-offs?

The last time I personally used it was over 10 years ago, but we got a
lot of use out of it to test system performance after making kernel
changes.  Of course, we used other benchmarks and microbenchmarks too.

Now that it has been GPL'd, I think it would be a useful addition to
Linux benchmarking.

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

