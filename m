Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287555AbSAEGyt>; Sat, 5 Jan 2002 01:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287558AbSAEGyk>; Sat, 5 Jan 2002 01:54:40 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:29455 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S287555AbSAEGyb>;
	Sat, 5 Jan 2002 01:54:31 -0500
Date: Sat, 5 Jan 2002 01:42:42 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.2-pre8: drivers/char/lp.c compile error
Message-ID: <Pine.LNX.4.33.0201050138500.12846-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

While 'make bzImage', I received the following error:

...
lp.c: In function 'lp_console_device':
lp.c:686: imcompatible type in return
lp.c:687: warning: control reaches end of non-void function
Amake[2]: *** [lp.o] Error 1
make[2]: Leaving directory '/usr/src/linux/drivers/char'
...

Regards,
Frank

