Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136477AbRAMKvl>; Sat, 13 Jan 2001 05:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136600AbRAMKvb>; Sat, 13 Jan 2001 05:51:31 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:22542 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S136477AbRAMKvW>; Sat, 13 Jan 2001 05:51:22 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA2569D3.003B97D1.00@d73mta05.au.ibm.com>
Date: Sat, 13 Jan 2001 17:12:48 +0630
Subject: problem installing in ibm ps/2 server95 with pentium 90 
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
            I am trying to install linux on IBM PS/2 server 95 MCA machine
with Pentium 90 .  But it is not bootingSince it is not booting fro the CD
I am booting the kernel from floppy disk with boot.img. The halts after the
message "POSIX conformance testing by UNIFIX".  The kernel parameters that
I gave are  :  mca-pentium   no-hlt  nosmp . Have anyone installed Linux in
a machine with this configuration. How should I proceed....HELP!!

Shiju


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
