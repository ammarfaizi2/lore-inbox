Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbTDCSsD 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263417AbTDCSpO 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:45:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54189 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id S263418AbTDCSnq 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:43:46 -0500
X-Sieve: cmu-sieve 2.0
Envelope-to: mbligh@localhost
Delivery-date: Thu, 03 Apr 2003 09:56:00 -0800
Date: Thu, 3 Apr 2003 09:55:34 -0800
Message-Id: <200304031755.h33HtYU16043@bugme.osdl.org>
From: bugme-daemon@osdl.org
To: mbligh@aracnet.com
X-Bugzilla-Reason: AssignedTo
Subject: [Bug 538] New: Rebooting of pentium-I during initial booting phase.
X-Resent-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=538

           Summary: Rebooting of pentium-I during initial booting phase.
    Kernel Version: 2.5.65 (probably most versions of 2.5.x)
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: robins.t@kutumb.org.in


Distribution: linus kernel 2.5.65 (probably 2.5.x)

Hardware Environment: 
Pentium - I (120 MHz) with FO-OF Bug
Motherboard Via - With DMA Problem ("nodma" option required in 2.4.x kernels)
16mb RAM (EDO)

Software Environment:
Linus kernel 2.5.65

Problem Description:
The new kernel 2.5.65 reboots while booting process (in the very initial phase) making even noting the progress very difficult.
The system is running fine with 2.4.21-pre5, with the option "nodma".

Steps to reproduce:
simply boot with 2.5.65!

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.



