Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287549AbSAEGKo>; Sat, 5 Jan 2002 01:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSAEGKe>; Sat, 5 Jan 2002 01:10:34 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:62727 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S287542AbSAEGKX>;
	Sat, 5 Jan 2002 01:10:23 -0500
Date: Sat, 5 Jan 2002 00:58:37 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.2-pre8: fs/ext3/super.c compile error
Message-ID: <Pine.LNX.4.33.0201050053070.6939-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I haven't seen the following posted.
While 'make bzImage', I received the following compile error:
...
super.c: In function 'make_rdonly':
super.c:59: invalid operands to binary !=
super.c:62: invalid operands to binary +
make[3]: *** [super.o] Error 1
make[3]: Leaving directory '/usr/src/linux/fs/ext3'
...

Regards,
Frank

