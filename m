Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbTCXX3J>; Mon, 24 Mar 2003 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261273AbTCXX3I>; Mon, 24 Mar 2003 18:29:08 -0500
Received: from fmr05.intel.com ([134.134.136.6]:31198 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261284AbTCXX2o>; Mon, 24 Mar 2003 18:28:44 -0500
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0C13A924@orsmsx107.jf.intel.com>
From: "Selbak, Rolla N" <rolla.n.selbak@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'posixtest-discuss@lists.sourceforge.net'" 
	<posixtest-discuss@lists.sourceforge.net>,
       "'phil-list@redhat.com'" <phil-list@redhat.com>
Subject: [ANNOUNCE] Open POSIX Test Suite 0.9.0
Date: Mon, 24 Mar 2003 15:39:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Release 0.9.0 of the Open POSIX Test Suite is now available at
http://posixtest.sourceforge.net.  This third release contains POSIX
conformance tests for the POSIX functions:

Threads (90% - not including tagged or rwlock-related functions)
Signals (90% complete)
Message queues (100% complete)
Semaphores (100% complete)
Timers (100% complete - tags TMR and CS)

It also contains bug fixes from 0.2.0.

The release notes that appear on download describe how to compile and run
these tests.

The README page and the Open POSIX Test Suite website (above) give more
information on the project goals and progress as well as information on how
to contribute or contact us if you are interested.

Many thanks to Jim Houston, Jerome Marchand and other members of the POSIX
testing community
for their bug fixes, patches, and suggestions on how to improve the 0.2.0
suite.

The Open POSIX Test Suite is an open source test suite with the goal of
creating conformance test suites, as well as potentially functional and
stress test suites, to the functions described in the IEEE Std 1003.1-2001
System Interfaces specification.  Initial work is focusing on timers,
threads, semaphores, signals, and message queues.

Feel free to contact posixtest-discuss@lists.sourceforge.net if you would
like further information.

Rolla

* my views are not necessarily my employer's *


