Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268386AbTBYW13>; Tue, 25 Feb 2003 17:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268388AbTBYW13>; Tue, 25 Feb 2003 17:27:29 -0500
Received: from tapu.f00f.org ([202.49.232.129]:7320 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S268386AbTBYW11>;
	Tue, 25 Feb 2003 17:27:27 -0500
Date: Tue, 25 Feb 2003 14:37:43 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Larry McVoy <lm@work.bitmover.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225223743.GA22579@f00f.org>
References: <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1046093309.1246.6.camel@irongate.swansea.linux.org.uk> <20030225051956.GA18302@f00f.org> <20030225052602.GW10411@holomorphy.com> <20030225212115.GB21870@f00f.org> <20030225212134.GD10411@holomorphy.com> <20030225220811.GA9317@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225220811.GA9317@work.bitmover.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 02:08:11PM -0800, Larry McVoy wrote:

> Without doing something about the page coloring problem (and he
> might be) the numbers will be fairly meaningless.

page coloring problem?

i was under the impression on anything 8-way-associative or better the
page coloring improvements were negligible for real-world benchmarks
(ie. kernel compiles)

... or is this more an artifact that even though the improvements for
real-world are negligible, micro-benchmarks are susceptible to these
variations this making things like the std. dev. larger than it would
otherwise be?



  --cw

