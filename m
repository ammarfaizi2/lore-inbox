Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264413AbTCXVAi>; Mon, 24 Mar 2003 16:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbTCXVAh>; Mon, 24 Mar 2003 16:00:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45994 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264413AbTCXVAh>; Mon, 24 Mar 2003 16:00:37 -0500
Date: Mon, 24 Mar 2003 13:01:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 496] New: No ataraid support in 2.5.65? 
Message-ID: <539260000.1048539712@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=496

           Summary: No ataraid support in 2.5.65?
    Kernel Version: 2.5.65
            Status: NEW
          Severity: high
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: zhen@gentoo.org


Distribution: Gentoo 1.4_rc3
Hardware Environment: AMD Athlon XP 1900+
Software Environment: gcc 3.2.2/ GLIBC 2.3.2
Problem Description:

This may not actually be a problem, but I have not seen anything in the kernel
config or the source itself for ataraid under x86. I have checked the mailing
lists, but there is no pertinent information there. I am using a HighPoint 370
PCI RAID controller. Either I am missing this, or the support is just not there.
Any information?

Steps to reproduce: Look for ataraid support in the kernel config. It is not
there. A `grep -irn ataraid *` in the kernel source tree returns ataraid only in
non-x86 architectures.


