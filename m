Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272460AbRIFMBo>; Thu, 6 Sep 2001 08:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272462AbRIFMBe>; Thu, 6 Sep 2001 08:01:34 -0400
Received: from post.rzg.mpg.de ([130.183.9.21]:32667 "EHLO post.rzg.mpg.de")
	by vger.kernel.org with ESMTP id <S272460AbRIFMB1>;
	Thu, 6 Sep 2001 08:01:27 -0400
Date: Thu, 6 Sep 2001 14:01:45 +0200
From: Karl Lehnberger <kjl@ipp.mpg.de>
Message-Id: <200109061201.OAA34908@post.rzg.mpg.de>
To: linux-kernel@vger.kernel.org
Subject: Drivers for fiber optic NICs
Cc: kjl@rzg.mpg.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any intentions to integrate drivers for NICs (10/100 Mbps Ethernet,
with a fiber optic as well as a copper port) into the kernel by default?
Which drivers of the present kernel releases (2.4.x) do support
those NICs and can automatically recognize which port is active?

For kernel releases 2.2.x for instance it was rather time consuming to find 
appropriate drivers for the NIC SMC 9432FTX-SC. For some versions of
the 2.2.x kernel line (in particular smp kernels) it was not possible
to get the fiber optic interface to work. Forgive me if this statement
is no longer true, I made some tests a year ago.
For 2.4.x kernels the default driver epic100 for this NIC is also not 
fiber optic capable.

Perhaps someone can give me some advice, especially which fiber/copper
NICs can be called "linux compatible", i.e. an appropriate driver is integrated 
into the kernel 2.4.x by default.
Thanks for help!

Regards,
-Karl
