Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263712AbSITWC5>; Fri, 20 Sep 2002 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263752AbSITWC5>; Fri, 20 Sep 2002 18:02:57 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:36747 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S263712AbSITWC4>; Fri, 20 Sep 2002 18:02:56 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE9E@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI: Call for testers
Date: Fri, 20 Sep 2002 15:07:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since the last ACPI revision made it into the 2.4 kernel (10 months ago) we
have been making steady improvement. Successive versions have been tested by
subscribers to the acpi-devel mailing list, but to really be confident this
patch is suitable for inclusion in the 2.4 stable branch, it needs testing
from an even wider audience. We're hoping you can help. :)

There are three pieces of data we're looking for, from as wide a spectrum of
x86 machines as possible:

1) Does it boot?
(Does the system hang, oops, or otherwise fail in a non-graceful manner)

2) Does it configure PCI interrupts properly?
(/proc/interrupts may not be the same before and after, but devices should
work like they did before the patch)

3) How do your results compare to the existing ACPI code in 2.4.x? Anything
else interesting?
(optional)

If you're willing, please download the ACPI patch from here:
http://sourceforge.net/project/showfiles.php?group_id=36832&release_id=11156
2

Please report your observations either to me, or preferably to
acpi-devel@sourceforge.net.

Thanks for your feedback!

Regards -- Andy


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

