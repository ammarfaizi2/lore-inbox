Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268670AbTBZHNU>; Wed, 26 Feb 2003 02:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268671AbTBZHNT>; Wed, 26 Feb 2003 02:13:19 -0500
Received: from [209.195.52.120] ([209.195.52.120]:25840 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S268670AbTBZHNS>; Wed, 26 Feb 2003 02:13:18 -0500
From: David Lang <david.lang@digitalinsight.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2003 23:22:16 -0800 (PST)
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030226054240.GL10411@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302252254170.8609-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, William Lee Irwin III wrote:

> In article <...> someone wrote:
> >> unfortunantly for them the core CPU speeds became uncoupled from the
> >> memory speeds and skyrocketed up to the point where CISC cores are as fast
> >> or faster then the 'high speed' RISC cores.
>
> On Wed, Feb 26, 2003 at 06:30:50AM +0100, Bernd Eckenfels wrote:
> > Hmm.. are there any RISC Cores which run even closely to CISC Speeds?
> > And why not? Is this only the financial power of Intel?
>
> There is one other: x86 binary compatibility.
>
> Looks like the beginning and end of it to me.

it's more then just the financial power of Intel, AMD is also in many ways
above the performance of the 'high-end' processors

aceshardware has a chart showing several different processors (dated in
october 2002 so it's not _that_ out of date

http://www.aceshardware.com/read_news.jsp?id=60000436

one interesting thing I see from this chart is that the x86 processors are
well ahead in integer performance and pulling further ahead (the pace of
development is significantly faster then the other processors) while they
do lag in floating point (but not by that much) there are a LOT of
workloads where the floating point performance is not as important (the K2
showed that it can't lag _to_ far behind)

the x86 binary compatability means that even a 'low volume' x86
compatable chip has a large potential market and a company can do
reasonably well getting a small percentage of the market (see the
transmeta and cyrix shiips) while the non x86 chips (including ia64) have
to invent a new market segment for themselves.

David Lang
