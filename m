Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNSAh>; Thu, 14 Dec 2000 13:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLNSA1>; Thu, 14 Dec 2000 13:00:27 -0500
Received: from SMTP1.ANDREW.CMU.EDU ([128.2.10.81]:44693 "EHLO
	smtp1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129260AbQLNSAP>; Thu, 14 Dec 2000 13:00:15 -0500
Date: Thu, 14 Dec 2000 12:30:40 -0500
From: Frank Davis <fdavis@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: test13-1, no subversion change on the Makefile
Message-ID: <1839463874.976797040@primetime2>
Originator-Info: login-token=Mulberry:01RYDjbavkROOA/jLkkABa3JjdWpnL63Bz41DiRfBW9g==;
 token_authority=postmaster@andrew.cmu.edu
X-Mailer: Mulberry/2.0.3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I downloaded test13-1.gz, and noticed that it didn't have a subversion 
change in it.

eg:

--- Makefile
+++ Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 0
-EXTRAVERSION = -test12
+EXTRAVERSION = -test13

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
