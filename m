Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbRBBUvK>; Fri, 2 Feb 2001 15:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbRBBUvA>; Fri, 2 Feb 2001 15:51:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:49671 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129261AbRBBUur>; Fri, 2 Feb 2001 15:50:47 -0500
Date: Fri, 2 Feb 2001 14:45:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] PCI-SCI Drivers v1.1-5 released
Message-ID: <20010202144531.A2376@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux Kernel,

Version 1.1-5 of the Dolphin PCI-SCI (Scalable Coherent Interface) drivers
for Linux kernels 2.2.X and 2.4.X have been posted at 
vger.timpanogas.org:/sci.  These drivers are freely 
available under the GNU public License and are provided in both 
RPM and tar.gz format.  

NOTES:

These release enables some optimizations for the PSB66 66Mhz Adapters 
in the /sbin/PSB66/scitools utilities.  Additionally, the Adapter 
configuration utilities and diagnostics are now organized under 
/opt/DIS/sbin/{ PSB32, PSB64, PSB66 } depending on which adapter 
is installed in your system.  

Please direct any comments, questions, or bug reports to 
jmerkey@timpanogas.org or linux-kernel@vger.kernel.org relative 
to these drivers.

Jeff Merkey
Chief Engineer, TRG


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
