Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTEEQVZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTEEQTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:19:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36790 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263309AbTEEQSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:18:06 -0400
Date: Mon, 05 May 2003 09:30:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 638] New: can't boot into kernel version 2.5.68
Message-ID: <9310000.1052152204@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=638

           Summary: can't boot into kernel version 2.5.68
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: dbzdeath@orcon.net.nz


Distribution: Redhat
Hardware Environment: 1.8ghz Athlon
Software Environment: Redhat 9.0
Problem Description: When upgrading my kernel from redhats 2.4.20-9 kernel
to 2.5.68 and i try to boot into the new kernel it freezes here with no
known error: 0MB HIGHMEM available.
511MB LOWMEM available.

Steps to reproduce: i extracted the tar file ran make menuconfig then make
install which had no errors then changed my grub config


