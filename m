Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUBARN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 12:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbUBARN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 12:13:56 -0500
Received: from hb6.lcom.net ([216.51.236.182]:60032 "EHLO
	petrus.dynamic.digitasaru.net") by vger.kernel.org with ESMTP
	id S265371AbUBARNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 12:13:55 -0500
Date: Sun, 1 Feb 2004 14:19:53 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI breakage in 2.6.2-rc3 (and before)
Message-ID: <20040201201950.GA9315@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401301823500.2847@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401301823500.2847@home.osdl.org>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Linus Torvalds on Friday, 30 January, 2004:
>The bulk of this is an ACPI update, but there's USB, ia-64, i2c, XFS and 
>PCI hotplug updates here too.
>Please don't send in anything but critical fixes until after the final 
>2.6.2 release.

Hmm.  I just tried 2.6.2-rc3 (after having tried 2.6.1 after having
  tried 2.6.2-rc2-mm1), and I note that ACPI can get my battery
  status in 2.6.1, but *not* in 2.6.2-rc2-mm1 or in 2.6.2-rc3.
  It notes that there is a battery in one of the two bays, and
  that it's on battery or AC power, but nothing more; all status
  readouts say that the battery's drained.

System is a Dell Inspiron 8600.

Thanks!


-Joseph
