Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVFIUGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFIUGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVFIUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 16:06:40 -0400
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:60649
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261515AbVFIUGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 16:06:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17064.41290.461755.920152@ccs.covici.com>
Date: Thu, 9 Jun 2005 16:06:34 -0400
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: e1000 not working using 2.6.11
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am not getting good results on a box I have which uses an Intel
Pro gigabit Ethernet driver for its network connection.  What happens
is that I get messages like watchdog xmit timeout and lots of errors
out of ifconfig.  Here is the listpci entry for that card.  It works
under the other OS, so I imagine the hardware is OK.

0000:01:0b.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp.: Unknown device 3013
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 19
        Memory at e7000000 (64-bit, non-prefetchable) [size=128K]
        Memory at e7020000 (64-bit, non-prefetchable) [size=64K]
        I/O ports at b400 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-


Any assistance would be appreciated.
 

-- 
Your life is like a penny.  You're going to lose it.  The question is:
How do
you spend it?

         John Covici
         covici@ccs.covici.com
