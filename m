Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTBPQFV>; Sun, 16 Feb 2003 11:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTBPQFU>; Sun, 16 Feb 2003 11:05:20 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64391 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267276AbTBPQFS>; Sun, 16 Feb 2003 11:05:18 -0500
Date: Sun, 16 Feb 2003 08:15:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 368] New: Permedia 3 driver broken
Message-ID: <16040000.1045412110@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=368

           Summary: Permedia 3 driver broken
    Kernel Version: 2.5.60
            Status: NEW
          Severity: high
             Owner: jsimmons@infradead.org
         Submitter: donaldlf@i-55.com


Distribution: redhat
Hardware Environment: LX164 / Athlon
Software Environment:rawhide
Problem Description:

module fails to compile. needs massive updatw. (missing 
header files, structures etc. ) Appears last update
was for 2.5.2 in early 2002

Steps to reproduce:
select Permedia 3 framebuffer and attempt to compile.

