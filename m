Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTAQJ1r>; Fri, 17 Jan 2003 04:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAQJ1r>; Fri, 17 Jan 2003 04:27:47 -0500
Received: from mta.sara.nl ([145.100.16.144]:47100 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S267187AbTAQJ1q>;
	Fri, 17 Jan 2003 04:27:46 -0500
Date: Fri, 17 Jan 2003 10:36:30 +0100
From: Remco Post <r.post@sara.nl>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Open source hardware
Message-Id: <20030117103630.1807b78f.r.post@sara.nl>
In-Reply-To: <200301161711.h0GHBKMS001969@darkstar.example.net>
References: <200301161711.h0GHBKMS001969@darkstar.example.net>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003 17:11:20 +0000 (GMT)
John Bradford <john@grabjohn.com> wrote:

> I've been reading some of the threads about the GPL, and binary-only
> drivers, and I'm suprised that nobody has brought up open source
> hardware, (or rather, the lack of it).
> 
> Open source hardware more or less sidesteps the whole issue of
> closed-source drivers - an open source driver would be so easy to
> write with all the specifications available that there would be very
> little point in writing a closed-source driver.
> 
> At the moment there is not very much open source hardware, and what
> does exist is generally peripherals, and not things like CPUs, but I
> expect this will change soon, mainly because it would be easy to
> develop a cheap, and simple CPU that is designed for multi-processor
> use from the beginning.

Hmm, cpu design is never simple, that is why big companies pay huge money to
highly educated professionals to work for them in designing CPUs.
> 
> This means that each CPU would be cheap and easy to produce, (simple
> design = high yeild from each wafer, and mass production = low cost
> per unit).  Typical machines would have several orders of magnitude
> more processors than those of conventional design, (E.G. 4 to 16 for a
> desktop), but they would be far cheaper, because anybody would be free
> to fabricate the CPUs.

Cheap, simple CPUs, and multiple of those? Like transputers? Ohw, those were
not that simple it turned out, they were designed ground up to work in
multiprocessor environments. They were not that relyable either, about 1 in
17 would for some reason not work after a power-down, luckily, it was not
determined which one that would be, hot spare CPU's were the answer. ;-)

> 
> So, basically, the idea is to design a low-cost,
> low-computational-power CPU, which works well in multi-processor
> configurations, and make the specification open source.  Anybody could
> make the processors, and building a machine of a given computational
> power would be cheaper using them than using conventional CPUs.
> 
> I personally expect to see this within 10 years.
> 

I personally expect not to see this in the next 10 years. Nobody bothers to
build smp 68040 boxes currently, this is a cheap (relatively), easy to use,
multiprocessor capable cpu. Why not? well, on big PPC is a lot easier on the
hardware, a lot faster and in the end, a lot cheaper.

> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Oh, BTW remember the Apple ][? One could get all hardware docs for that
bocs, schematics for the entire circuit, the works. That made it very easy
to build clones, and some people did that, turned out, those were not much
cheaper that apple's original box....

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams
