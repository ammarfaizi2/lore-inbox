Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSIWVnF>; Mon, 23 Sep 2002 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261481AbSIWVnF>; Mon, 23 Sep 2002 17:43:05 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:57494 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261478AbSIWVmf>;
	Mon, 23 Sep 2002 17:42:35 -0400
Message-ID: <1032817665.3d8f8c0156b2e@kolivas.net>
Date: Tue, 24 Sep 2002 07:47:45 +1000
From: Con Kolivas <conman@kolivas.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Corrected gcc3.2 v gcc2.95.3 contest results
References: <Pine.LNX.3.95.1020923101125.3233A-100000@chaos.analogic.com> <1032791089.3d8f2431231ac@kolivas.net> <20020923163452.GF9726@waste.org>
In-Reply-To: <20020923163452.GF9726@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Oliver Xymoron <oxymoron@waste.org>:

> On Tue, Sep 24, 2002 at 12:24:49AM +1000, Con Kolivas wrote:
> > 
> > That is the system I was considering. I just need to run enough
> > benchmarks to make this worthwhile though. That means about 5 for
> > each it seems - which may take me a while. A basic mean will suffice
> > for a measure of central tendency. I also need to quote some measure
> > of variability. Standard deviation?
> 
> No, standard deviation is inappropriate here. We have no reason to
> expect the distribution of problem cases to be normal or even smooth.
> What we'd really like is range and mean. Don't throw out the outliers
> either, the pathological cases are of critical interest.

Yes. Definitely the outliers appear to make the difference to the results. The
mean and range appear to be the most important on examining this data. The only
purpose to quoting other figures would be for inferential statistics to
determine if there is a statistically significant difference to the groups. My
overnight benchmarking has generated a few results and I will publish something
soon.

Con.

