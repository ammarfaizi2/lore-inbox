Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTAPWQA>; Thu, 16 Jan 2003 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTAPWQA>; Thu, 16 Jan 2003 17:16:00 -0500
Received: from [81.2.122.30] ([81.2.122.30]:55814 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267299AbTAPWP7>;
	Thu, 16 Jan 2003 17:15:59 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301162225.h0GMP0YI003249@darkstar.example.net>
Subject: Re: Open source hardware
To: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 16 Jan 2003 22:25:00 +0000 (GMT)
Cc: Herman@wirelessnetworksinc.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030116173634.GA16376@gtf.org> from "Jeff Garzik" at Jan 16, 2003 12:36:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've been reading some of the threads about the GPL, and binary-only
> > drivers, and I'm suprised that nobody has brought up open source
> > hardware, (or rather, the lack of it).
> [...]
> > So, basically, the idea is to design a low-cost,
> > low-computational-power CPU, which works well in multi-processor
> > configurations, and make the specification open source.  Anybody could
> > make the processors, and building a machine of a given computational
> > power would be cheaper using them than using conventional CPUs.
> > 
> > I personally expect to see this within 10 years.
> 
> You're behind the times :)
> 
> http://www.opencores.org/

Interesting - I'd only seen open source CPU projects which were at the
planning stage.

It seems that most of the components necessary to build a usable
machine are at least well-advanced, although most of the non-CPU parts
are based around the WISHBONE interface, whereare most of the CPUs are
not, so maybe the goal is further away than it first appears, but
still, progress is being made.

Do you know of anybody who has actually made a prototype board from
any of these CPU designs?  Is my idea of running a lot of simple CPUs
together fundamentally flawed, or is it possible to overcome the
inefficiencies of SMP, if the CPUs are designed for it from the ground
up?

To be honest I am really begining to get bored with i386-based
systems, and I'm hoping to move away from them entirely at the
earliest opportunity.  Hopefully I'll be building my next machine
around an UltraSPARC, but I've really been a bit too busy with other
projects lately...

John.
