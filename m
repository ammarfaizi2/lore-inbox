Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRB0Gy1>; Tue, 27 Feb 2001 01:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRB0GyR>; Tue, 27 Feb 2001 01:54:17 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:24877 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129106AbRB0GyF>; Tue, 27 Feb 2001 01:54:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [Announce] kdb v1.8 is available
Date: Tue, 27 Feb 2001 17:52:41 +1100
Message-ID: <31732.983256761@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

http://oss.sgi.com/projects/kdb/download/ix86/ contains patches for kdb
v1.8 against 2.4.2 and 2.4.2-ac5.

The main reason for this release is to hook into the panic() routine
and to sync with the NMI changes in the -ac series.  kdb-v1.8-2.4.2-ac5
has been tested on SMP, the UP NMI code has not been tested, it relies
on the -ac patch.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6m064i4UHNye0ZOoRAlr8AKCN657mDGbSiQuOZEfEerk2u6xcmwCg09K6
GnlCQTeyUFhXNMQXY3CgunU=
=RNp7
-----END PGP SIGNATURE-----

