Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBHU1H>; Sat, 8 Feb 2003 15:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267117AbTBHU1G>; Sat, 8 Feb 2003 15:27:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34234 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267107AbTBHU0q>; Sat, 8 Feb 2003 15:26:46 -0500
Date: Sat, 08 Feb 2003 12:36:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 328] New: The computer seems to hang after the kernel has
 uncompressed and starts to boot.
Message-ID: <20980000.1044736584@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=328

           Summary: The computer seems to hang after the kernel has
                    uncompressed and starts to boot.
    Kernel Version: 2.5.59
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: di00enad@ing.hj.se


Distribution: RedHat 8.0
Hardware Environment: Acer Aspire 1300 laptop
Software Environment: RedHat 8.0, GCC 3.2, LILO
Problem Description: When I have compiled the kernel without problems and 
restart the computer the only two lines that are printed are:

Booting 2.5.59
Uncompressing the kernel, Ok booting the kernel

then there is no more text printed out and the keyboard do not work. But I
can  see some activity on the harddisk for about 10 seconds. When I reset
the  computer fsck is run because the disk was not cleanly unmounted. It
seems like  the system can almost boot but I can't see anything on the
screen.


