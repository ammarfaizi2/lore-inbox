Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbTBCTyK>; Mon, 3 Feb 2003 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTBCTxG>; Mon, 3 Feb 2003 14:53:06 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:60378 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265250AbTBCTwg> convert rfc822-to-8bit; Mon, 3 Feb 2003 14:52:36 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH, =?iso-8859-1?q?B=F6blingen?=
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes.
Date: Mon, 3 Feb 2003 20:59:03 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200302032042.42981.schwidefsky@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
Arnd hacked kmail to do what we want. This time the patches are encoded
with quoted-printable. This should work, at least it did in the past.
The short descriptions again:
1) updates for the channel subsystem driver
2) bug fixes for the ctc driver
3) bug fixes for the dasd driver
4) some documentation changes
5) use unified extable code
6) compile fixes for upcoming gcc-3.3
7) code clean up of the iucv driver
8) Kconfig updates
9) updates for the qdio driver
10) updates for the s390 scsi support
11) enable TLS support for s390
12) trivial bug fixes.

blue skies,
  Martin.

P.S.
To anybody who is using kmail and want to send patches to linux-kernel:
kmail 1.5 that comes with kde 3.1 is broken. It removes ^L from messages
(sends them with 7bit encoding instead of quoted printable).

