Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVKLSNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVKLSNx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 13:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVKLSNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 13:13:52 -0500
Received: from mail.junik.lv ([195.216.160.134]:53520 "EHLO mail.junik.lv")
	by vger.kernel.org with ESMTP id S932421AbVKLSNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 13:13:52 -0500
Message-Id: <200511121813.jACIDpXa055161@mail.junik.lv>
From: "Alexander Kozyrev" <kozyrev@junik.lv>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: kernel compilation
Date: Sat, 12 Nov 2005 20:13:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook, Build 11.0.5207
Thread-Index: AcXntM7/aivE8LRZSB+48DYRIOjhPQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux asterisk1.local 2.6.9-11.EL #1 Wed Jun 8 16:59:52 CDT 2005 i686 i686
i386 GNU/Linux
After 2 hours of compilation -
<......>
  CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  CC [M]  lib/crc-ccitt.o
  CC [M]  lib/libcrc32c.o
  LD      arch/i386/lib/built-in.o
  CC      arch/i386/lib/bitops.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
ld: kernel/built-in.o: No such file: No such file or directory
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

4 times with the same error.

