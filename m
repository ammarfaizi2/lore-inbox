Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSGISHb>; Tue, 9 Jul 2002 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317364AbSGISHa>; Tue, 9 Jul 2002 14:07:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:42299 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317363AbSGISH3>; Tue, 9 Jul 2002 14:07:29 -0400
Date: Tue, 9 Jul 2002 12:49:16 -0500 (CDT)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Test Suite  LTP-20020709.tgz has been released.
Message-ID: <Pine.LNX.4.33.0207091247001.13100-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Linux Test Project test suite LTP-20020709.tgz has been released.
Visit our website ( http://ltp.sourceforge.net )to download the latest
version of the test suite, and, for information on test results on pre
release, release candidate and stable releases of the kernel. There is
also a list of test cases that are expected to fail, please find the list
at http://ltp.sourceforge.net/expected-errors.php


We encourage the community to post results, patches or new tests on
our mailing list and use the CVS bug tracking facility to report problems
that you might encounter with the test suite. More details available at
our web-site.

Change Log
----------
* New Additions
---------------
- New testcases fcntl22, link06, link07,
  mknod09                                        ( Bull Group         )
- New sctp tests                                 ( Robert Williamson  )
- New direct IO tests                            ( Narasimha Sharoff  )
- mlock01 and mlock02 tests                      ( Paul Larson        )

* Fixes
----------------
- MIPS fixes; write01                            ( Shaobo Li          )
- patches for 64bit and warnings                 ( Ihno Krumreich     )
- fixes for ftruncate02, fchown03                ( Robert Williamson  )
- updates to LTP scripts                         ( Nathan Straz       )

Thanks
Manoj Iyer

*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

