Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131313AbQLLExm>; Mon, 11 Dec 2000 23:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131373AbQLLExc>; Mon, 11 Dec 2000 23:53:32 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:4184 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131313AbQLLExX>; Mon, 11 Dec 2000 23:53:23 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@melbourne.sgi.com>
To: kdb@oss.sgi.com, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [Announce] kdb v1.7 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Dec 2000 15:21:34 +1100
Message-ID: <6020.976594894@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://oss.sgi.com/projects/kdb/download/ix86/ contains patches for kdb
v1.7 against 2.4.0-test11 and 2.4.0-test12.

There is a large amount of internal reorganisation from kdb v1.6 to
v1.7 to make it easier to support multiple architectures.  Most of this
is feedback from the kdb for IA64 work in progress.

The patch against 2.4.0-test11 fixes the boot hang with NMI for UP.

kdb v1.7 contains a new "sections" command.  Primarily intended for
interfacing to external debuggers such as gdb, its output is not very
human readable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
