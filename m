Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281031AbRKGWjR>; Wed, 7 Nov 2001 17:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281037AbRKGWjI>; Wed, 7 Nov 2001 17:39:08 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:48772 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281031AbRKGWiw>; Wed, 7 Nov 2001 17:38:52 -0500
Subject: [ANNOUNCE] Linux Test Project ltp-20011107 released
From: Paul Larson <plars@austin.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 07 Nov 2001 16:43:05 +0000
Message-Id: <1005151385.18455.2.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Linux Test Project ltp-20011107 was released today.  For more
information about the Linux Test Project, or to download the testsuite,
see our website at http://ltp.sourceforge.net.          


Changelog
---------
o       Many improvements to mtest05 and mtest06 tests
o       new test nfsstress
o       included ver_linux in LTP and made it run at the 
	end of test scripts
o       check for necessary users/groups in Makefile 
	and warn if they don't exist
o       documented the users and groups necessary for 
	the testcases to run
o       simplified telnet01 when looking for root prompt
o       removed incorrect testcase from sendfile03
o       fixed modify_ldt01 test problems on newer kernels
o       added setrlimit to unlimit core size in waitpid05 
	test to work around systems where this is set to 0
o       fixed mmstress pthread hang problem

