Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274936AbTHPUen (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274916AbTHPUeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 16:34:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:3592 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S274929AbTHPUd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 16:33:27 -0400
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Dumb question: Why are exceptions such as SIGSEGV not logged
Date: Sun, 17 Aug 2003 04:10:30 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170410.30844.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux logs almost everything, why not exceptions such as SIGSEGV in userspace which
may be very informative?

Regards
Michael

-- 
Powered by linux-2.6. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/


