Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268171AbTB1Usg>; Fri, 28 Feb 2003 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268175AbTB1Usg>; Fri, 28 Feb 2003 15:48:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:26532 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268171AbTB1Usf>; Fri, 28 Feb 2003 15:48:35 -0500
Date: Fri, 28 Feb 2003 12:49:45 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 423] New: make -j X bzImage gives a warning 
Message-ID: <347860000.1046465385@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=423

           Summary: make -j X bzImage gives a warning
    Kernel Version: 2.5.63
            Status: NEW
          Severity: low	
             Owner: zippel@linux-m68k.org
         Submitter: mbligh@aracnet.com


make -j X bzImage gives a warning:

make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make
rule.

Can we get rid of this one way or the other?

