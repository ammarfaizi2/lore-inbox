Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263894AbRGCKcK>; Tue, 3 Jul 2001 06:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRGCKcA>; Tue, 3 Jul 2001 06:32:00 -0400
Received: from juicer38.bigpond.com ([139.134.6.95]:38871 "EHLO
	mailin7.bigpond.com") by vger.kernel.org with ESMTP
	id <S263894AbRGCKby>; Tue, 3 Jul 2001 06:31:54 -0400
Message-Id: <m15HLZc-000CD6C@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: Greg KH <greg@kroah.com>
Subject: [ANNOUNCE] HotPlug CPU patch against 2.4.5
Date: Tue, 03 Jul 2001 18:30:19 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	http://sourceforge.net/projects/lhcs/

	Version 0.5 (should actually compile) of the HotPlug CPU Patch
is out.  This adds /sbin/hotplug support (thanks Greg), which is
almost useful.

	Of course, /sbin/hotplug falls far short of allowing you to
stop CPUs from going down or coming up, or do something *before* CPUs
go down or up, and it uses env vars to pass what it's doing, but we've
had worse infrastructure in the kernel *cough*sysctl*cough*.  </rant>

Cheers!
Rusty.
--
Premature optmztion is rt of all evl. --DK
