Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSGVDS7>; Sun, 21 Jul 2002 23:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSGVDS7>; Sun, 21 Jul 2002 23:18:59 -0400
Received: from [210.78.134.243] ([210.78.134.243]:45839 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S315593AbSGVDS6>;
	Sun, 21 Jul 2002 23:18:58 -0400
Date: Mon, 22 Jul 2002 11:24:10 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: error when build linux-2.5.27
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207221126411.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when i build linux-2.5.27,i met some problem. the error message is as this:

linux-kernelmake[1]: Entering directory `/usr/src/linux-2.5.27/arch/i386/kernel'
  gcc -Wp,-MD,./.entry.o.d -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.5.27/i
nclude -nostdinc -iwithprefix include  -traditional  -c -o entry.o entry.S
/usr/lib/gcc-lib/i386-redhat-linux/2.96/tradcpp0: Usage: /usr/lib/gcc-lib/i386-r
edhat-linux/2.96/tradcpp0 [switches] input output
make[1]: *** [entry.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.27/arch/i386/kernel'
make: *** [arch/i386/kernel] Error 2

so how to solve the problem?
please cc. thanks.

chuanbo zheng
zhengcb@netpower.com.cn

