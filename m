Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288460AbSATV6f>; Sun, 20 Jan 2002 16:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSATV60>; Sun, 20 Jan 2002 16:58:26 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:50696 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S288460AbSATV6Q>;
	Sun, 20 Jan 2002 16:58:16 -0500
Date: Sun, 20 Jan 2002 16:46:30 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.3-pre2: isdn_common.c compile error
Message-ID: <Pine.LNX.4.33.0201201644001.1213-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    While 'make modules', I received the following error:

Regards,
Frank

isdn_common.c: In function `isdn_register_devfs':
isdn_common.c:2256: `ISDN_MINOR_B' undeclared (first use in this function)
isdn_common.c:2256: (Each undeclared identifier is reported only once
isdn_common.c:2256: for each function it appears in.)
make[2]: *** [isdn_common.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/isdn'
make[1]: *** [_modsubdir_isdn] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

