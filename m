Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318738AbSHLQJu>; Mon, 12 Aug 2002 12:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318742AbSHLQJu>; Mon, 12 Aug 2002 12:09:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24076 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318738AbSHLQJt>; Mon, 12 Aug 2002 12:09:49 -0400
Date: Mon, 12 Aug 2002 13:13:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mel <mel@csn.ul.ie>
cc: Daniel Phillips <phillips@arcor.de>,
       Bernd Eckenfels <ecki-news2002-08@lina.inka.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] VM Regress - A VM regression and test tool
In-Reply-To: <Pine.LNX.4.44.0208121637100.16360-100000@skynet>
Message-ID: <Pine.LNX.4.44L.0208121310180.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2002, Mel wrote:
> On Mon, 12 Aug 2002, Rik van Riel wrote:
>
> > On the other hand, if somebody could code up some scriptable
> > benchmarks that approximate real workloads better than the
> > current benchmarks do, I'd certainly appreciate it.
>
> This looks like an overall system benchmark again and while it would be
> great to have, it is not what I aim to provide here with VM Regress.
>
> > For web serving, for example, I wouldn't mind a benchmark that:
> >
> > <Benchmark snipped>
>
> That benchmarks like it would be more likely to test network throughput
> than VM performance although I could be misunderstanding your benchmark,

The thing is that the indivual 'users' will be downloading
files at modem and adsl speeds, meaning a LOT of apache
daemons could be sitting around on the server.

You are right though that this is more of an overall system
benchmark than a pure VM test.  On the other hand, the VM
doesn't function on its own, it really needs to be part of
a larger system ;)


> In VM Regress land, I would be much more likely to provide a benchmark
> that did something like the folllowing. (Remember that VM Regress aims
> to provide more than been a pure benchmarking tool. Benchmarking is just
> one aspect)

That might be a useful test.  How useful it would be we can't
really know until we've tried, but it definately does sound like
it's worth a try...


> > Volunteers ? ;)
>
> Not for that particular benchmark, but how useful would the VM Regress
> equivilant be?

I can't say in advance how useful it would be, but my gut
feeling is that it might help getting things right.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

