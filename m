Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTAPRCM>; Thu, 16 Jan 2003 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTAPRCM>; Thu, 16 Jan 2003 12:02:12 -0500
Received: from [81.2.122.30] ([81.2.122.30]:46341 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267158AbTAPRCL>;
	Thu, 16 Jan 2003 12:02:11 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301161711.h0GHBKMS001969@darkstar.example.net>
Subject: Open source hardware
To: linux-kernel@vger.kernel.org
Date: Thu, 16 Jan 2003 17:11:20 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been reading some of the threads about the GPL, and binary-only
drivers, and I'm suprised that nobody has brought up open source
hardware, (or rather, the lack of it).

Open source hardware more or less sidesteps the whole issue of
closed-source drivers - an open source driver would be so easy to
write with all the specifications available that there would be very
little point in writing a closed-source driver.

At the moment there is not very much open source hardware, and what
does exist is generally peripherals, and not things like CPUs, but I
expect this will change soon, mainly because it would be easy to
develop a cheap, and simple CPU that is designed for multi-processor
use from the beginning.

This means that each CPU would be cheap and easy to produce, (simple
design = high yeild from each wafer, and mass production = low cost
per unit).  Typical machines would have several orders of magnitude
more processors than those of conventional design, (E.G. 4 to 16 for a
desktop), but they would be far cheaper, because anybody would be free
to fabricate the CPUs.

So, basically, the idea is to design a low-cost,
low-computational-power CPU, which works well in multi-processor
configurations, and make the specification open source.  Anybody could
make the processors, and building a machine of a given computational
power would be cheaper using them than using conventional CPUs.

I personally expect to see this within 10 years.

John.
