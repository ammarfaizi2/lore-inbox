Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285305AbRLFX1U>; Thu, 6 Dec 2001 18:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285307AbRLFX1K>; Thu, 6 Dec 2001 18:27:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54718 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285305AbRLFX05>; Thu, 6 Dec 2001 18:26:57 -0500
Subject: [ANNOUNCE] Linux Test Project ltp-20011206 released
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Dec 2001 17:32:42 +0000
Message-Id: <1007659963.14970.56.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project ltp-20011206 has been released.  The LTP Test
Plan which was designed by SGI, OSDL, and IBM has been posted on the
website, and results for long runs of LTP on 2.4.14 and 2.4.16 have been
posted in the results section.  For more information about the Linux
Test Project, or to download the testsuite, see our website at
http://ltp.sourceforge.net.


Changelog
---------
o       necessary users/groups can now be created on installation with
        user's permission
o       added a simple menu-based interface for running the LTP testsuite
o       fixed negative duration in pan output when -l isn't used
o       new set of tests under fs-maim
o       fixed race condition in nfslock01
o       ar01, ld01, ldd01, nm01, objdump01, and size01 fixed when multiple
        copies are run simultaneously
o       workaround for SIGTTOU hang in ioctl02
o       shmget03 uses IPC_PRIVATE to make it safe when running multiple copies
o       compiler warnings and other minor errors fixed in many tests

