Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRKHQrQ>; Thu, 8 Nov 2001 11:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276312AbRKHQrF>; Thu, 8 Nov 2001 11:47:05 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:22663 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S275265AbRKHQqu>;
	Thu, 8 Nov 2001 11:46:50 -0500
Date: Thu, 8 Nov 2001 11:46:49 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: <linux-kernel@vger.kernel.org>
Subject: Any lingering Athlon bugs in Kernel 2.4.14?
Message-ID: <Pine.LNX.4.30.0111081141270.4578-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I am wondering if maybe there are any lingering Athlon bugs in Kernel
2.4.14?

I basically have a 33-node AMD Athlon Beowulf Cluster using the KT266
chipset.  I compiled kernel 2.4.14 optimized for athlons.

If I leave the computers up for several days, without fail random nodes in
the beowulf start to drop like flies.  Every other day, a different,
random node will get those Aiiiee messages and complain about some virtual
page request being invalid or somesuch, hanging the machine.

I am sure all the machines have good hardware as we ran thorough tests on
the machines using things like memtest86.  I only started experiencing
problems since upgrading the kernels from the stock redhat kernels that
came with those machines.

I haven't yet tried just compiling the kernel without the Athlon
optimizations.  I was wondering, though, if there are any known or
suspected issues with Athlons and the latest kernel?

Any help/advice/thoughts/even flames would be appreciated... :)

-Calin

