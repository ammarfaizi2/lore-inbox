Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSCMBx6>; Tue, 12 Mar 2002 20:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSCMBxs>; Tue, 12 Mar 2002 20:53:48 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:8709 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S291780AbSCMBxm>;
	Tue, 12 Mar 2002 20:53:42 -0500
Date: Tue, 12 Mar 2002 20:43:22 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.7-pre1: net/ipv4/ipmr.c compile error
Message-ID: <Pine.LNX.4.33.0203122041390.11115-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   While 'make bzImage', I received the following error.
Regards,
Frank

ipmr.c: In function `ip_mroute_setsockopt':
ipmr.c:858: structure has no member named `num'
make[3]: *** [ipmr.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/ipv4'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/net/ipv4'
make[1]: *** [_subdir_ipv4] Error 2
make[1]: Leaving directory `/usr/src/linux/net'
make: *** [_dir_net] Error 2


