Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271377AbTHHObk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHHObk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:31:40 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:50306 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271377AbTHHObh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:31:37 -0400
Date: Fri, 08 Aug 2003 07:31:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: rphillips@gentoo.org
Subject: [Bug 1059] New: 3c905B Driver Doesn't work in 2.6.0_test2
Message-ID: <24320000.1060353069@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1059

           Summary: 3c905B Driver Doesn't work in 2.6.0_test2
    Kernel Version: 2.6.0_test2
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: rphillips@gentoo.org


Distribution: Gentoo
Hardware Environment: Desktop Athlon-XP 2100+
Software Environment: 
Problem Description:
   dmesg displays my 3com 3c905B in dmesg.  Upon booting the OS and trying
unsuccessfully to get a DHCP address, a tried a static IP without any luck also.
 This computer has ran 2.4.20 and .21 alright with this particular driver.  I'm
not sure how t3reproduce:
  1. Get a 3C905B Network Card
  2. Install 2.6.0_test2
     a. Doesn't matter if driver is a module or in the kernel
  3. Assign and IP or try using DHCP
  4. Failure on pings to local computers on the LAN and a failure to get an IP
address.


