Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbREPE5K>; Wed, 16 May 2001 00:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbREPE47>; Wed, 16 May 2001 00:56:59 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48742 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S261786AbREPE4n>; Wed, 16 May 2001 00:56:43 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kdb@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: kdb v1.8 - 2.4.5-pre2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 14:55:19 +1000
Message-ID: <23198.989988919@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just uploaded kdb v1.8 against 2.4.5-pre2[*].  The only kdb change is
the ability to adjust the activation sequence on a serial line.  If you
dislike using control-A to enter kdb then change kdb_serial_str in
drivers/char/serial.c.

[*] http://oss.sgi.com/projects/kdb/download/ix86/.

