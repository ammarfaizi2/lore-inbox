Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284111AbRLOWh0>; Sat, 15 Dec 2001 17:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284088AbRLOWhQ>; Sat, 15 Dec 2001 17:37:16 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:1805 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S284079AbRLOWhH>;
	Sat, 15 Dec 2001 17:37:07 -0500
Message-ID: <3C1BD0DE.8080604@si.rr.com>
Date: Sat, 15 Dec 2001 17:38:22 -0500
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre11: drivers/block/xd.c
Content-Type: multipart/mixed;
 boundary="------------020208000103090901020101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208000103090901020101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
   While 'make modules', I received the following error (attached) .

Regards,
Frank

--------------020208000103090901020101
Content-Type: text/plain;
 name="XD"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="XD"

xd.c: In function `xd_init':
xd.c:173: too few arguments to function `blk_init_queue_Rsmp_ddfd7875'
make[2]: *** [xd.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

--------------020208000103090901020101--

