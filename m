Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269372AbRHTVDA>; Mon, 20 Aug 2001 17:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRHTVCu>; Mon, 20 Aug 2001 17:02:50 -0400
Received: from PSI.MIT.EDU ([18.77.0.154]:62337 "EHLO psi.mit.edu")
	by vger.kernel.org with ESMTP id <S269372AbRHTVCm>;
	Mon, 20 Aug 2001 17:02:42 -0400
Date: Mon, 20 Aug 2001 17:04:12 -0400 (EDT)
From: Taylan Akdogan <akdogan@mit.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Suspending a process into disk?
Message-ID: <Pine.LNX.4.33.0108201649520.24485-100000@psi.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I was wondering, if suspending a specific process into disk and
resuming from the disk after a reboot is possible.  Let's assume
that the process in question has a couple of open files for r/w,
say on ext2, if it makes difference, and it isn't using any
network connection.

It could be very useful, if you have to reboot the system while
your cpu-monster application is running for a long time...
Sometimes, I have to delay a necessary (minor) kernel update
because of week-long processes.

Regards,
Taylan

---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
Taylan Akdogan              Massachusetts Institute of Technology
akdogan@mit.edu                             Department of Physics
---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---

