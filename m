Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313573AbSDPD2u>; Mon, 15 Apr 2002 23:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313575AbSDPD2t>; Mon, 15 Apr 2002 23:28:49 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:38157 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S313573AbSDPD2s>;
	Mon, 15 Apr 2002 23:28:48 -0400
Date: Mon, 15 Apr 2002 22:19:24 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <davej@suse.de>, <fdavis@si.rr.com>
Subject: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error 
Message-ID: <Pine.LNX.4.33.0204152216590.18109-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While a 'make bzImage', I received the following compile error:
Regards,
Frank

smpboot.c:1008: parse error before `0'
smpboot.c: In function `smp_boot_cpus':
smpboot.c:1023: invalid lvalue in assignment
make[1]: *** [smpboot.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


