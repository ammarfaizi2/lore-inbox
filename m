Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSJHVjp>; Tue, 8 Oct 2002 17:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSJHVjp>; Tue, 8 Oct 2002 17:39:45 -0400
Received: from fmr01.intel.com ([192.55.52.18]:3014 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261411AbSJHVjo>;
	Tue, 8 Oct 2002 17:39:44 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF0F@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Iain McClatchie'" <iain@truecircuits.com>, linux-kernel@vger.kernel.org
Subject: RE: SMP ACPI S3 support in 2.4 series?
Date: Tue, 8 Oct 2002 14:45:22 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Iain McClatchie [mailto:iain@truecircuits.com] 
> I'm buying a number of SMP servers.  These machines will go
> idle for days at a time, and we'd like to send them into a
> suspend-to-RAM (ACPI state S3) while they are unused.
> 
> I want to know if this is even possible with the Linux 2.4
> series kernels, and if so, which hardware and kernel combinations
> support it.  I'd also like to know if anyone really has this
> working right now.
> 
> As dual Athlon systems appear to be the best performance/$ for
> my application, I'm especially interested in getting those to
> sleep, but I'll take any pointers I can get.

S3 is really more "off" than servers generally want to be. Servers typically
don't even support it.

I would think for a server, you would want to leave it on, and maybe turn
off the disks, or something.

Or maybe just turn the systems off.

2.4 doesn't (and won't) support S3, anyways.

Regards -- Andy
