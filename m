Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUDISFC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDISFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:05:02 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:33855 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261568AbUDISE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:04:59 -0400
Subject: ACPI
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081533812.1853.3.camel@FransonFamily.rn.byu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 (1.5.5-1) 
Date: Fri, 09 Apr 2004 14:04:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not entirely a bug report.  The last few kernels have been
getting better at dealing with my eMachines m6805 (Athlon 64 based).
The patch to fix up VIA irqs does NOT help with the via rhine in this
machine.  Also, pirqmask doesn't help when turning acpi configuration
off for the pcmcia (it hangs).

However, I can now view power status and unplug and plug in without the
machine hanging.  The biggest frustration is the lack of auto ACPI
configuration, this does seem to be getting better... that and the fact
I can't suspend to anything but mem and that hangs.  Suspend by standby
just flashes the screen and it is back.  This is likely an easy kernel
bug to fix, but I am not sure where to start.

I am not using x86-64 kernels.  I am using the x86 (686 variants) of
everything from Fedora Core test, or i386 where i686 is not available.

Good work everyone.  If there is any more information that would help,
let me know what and how to get it and I will fire it off.

Trever



