Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbTKNOhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 09:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKNOhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 09:37:19 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:55274 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S262570AbTKNOhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 09:37:17 -0500
Message-ID: <3FB4E87F.AD660571@sdl.hitachi.co.jp>
Date: Fri, 14 Nov 2003 23:36:47 +0900
From: sugita <sugita@sdl.hitachi.co.jp>
X-Mailer: Mozilla 4.78 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: LKST v2.0.0 is released (Kernel v2.6.0-test9)
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

   I'd like to announce publication of Linux Kernel State Tracer (LKST)
version 2.0.0,
which is a tracer for Linux kernel.
 LKST is a useful tool for analyzing Kernel fault and evaluating of
Kernel.

 LKST v2.0.0 is for Kernel version 2.6.0-test9(*).
And platforms of LKST 2.0.0 are both IA32 and IA64.
#The details are described in changes-2.0.0.txt.

*)LKST v2.0.0 is also for Kernel version 2.6.0-test8.
 After you executed LKST patches, please change EXTRAVERSION value in
Makefile
of Kernel to test8-lkst.

Remarks:
  for supporting IA64, we changed some codes in the following programs.
  - KernelHooks


 LKST binaries, source code and documents are available in the following
site,
        http://sourceforge.net/projects/lkst/
        http://sourceforge.jp/projects/lkst/

 We prepared a mailing list written below in order to let users know
update of LKST.

 lkst-users@lists.sourceforge.net
 lkst-users@lists.sourceforge.jp

 To subscribe, please refer following URL,

 http://lists.sourceforge.net/lists/listinfo/lkst-users
 http://lists.sourceforge.jp/mailman/listinfo/lkst-users

 And if you have any comments, please send to the above list, or to
another
mailing-list written below.

 lkst-develop@lists.sourceforge.net
 lkst-develop@lists.sourceforge.jp

 With kindest regards,
 All of the LKST developers

----------------
 Yumiko Sugita
 Hitachi,Ltd., Systems Development Laboratory
 E-mail: sugita@sdl.hitachi.co.jp

