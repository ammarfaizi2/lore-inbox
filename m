Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTHTIb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTHTIb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:31:27 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:51163 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S261826AbTHTIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:30:27 -0400
Message-Id: <5.1.1.9.2.20030820134120.05201298@sdl99c>
X-Mailer: QUALCOMM Windows Eudora Version 5.1-Jr4
Date: Wed, 20 Aug 2003 17:30:31 +0900
To: linux-kernel@vger.kernel.org
From: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
Subject: Release LKST v1.5
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

  I'd like to announce publication of Linux Kernel State Tracer(LKST)
version 1.5, which is a tracer for Linux kernel.

  We release patches to support both IA32 and IA64 platforms.
And we provide watchdog handler and heartbeat program (addons).
#The details are described in changes-1.5.txt.

Remarks:
   To support IA64, we changed some codes in the following programs.
   - KernelHooks
   - LKCD


  LKST binaries, source code and documents are available in the
following site,
         https://sourceforge.net/projects/lkst/
         http://sourceforge.jp/projects/lkst/

  We prepared a mailing list written below in order to let users
know update of LKST.

  lkst-users@lists.sourceforge.net
  lkst-users@lists.sourceforge.jp

  To subscribe, please refer following URL,

  http://lists.sourceforge.net/lists/listinfo/lkst-users
  http://lists.sourceforge.jp/mailman/listinfo/lkst-users

    And if you have any comments, please send to the above list,
or to another mailing-list written below.

  lkst-develop@lists.sourceforge.net
  lkst-develop@lists.sourceforge.jp

  With kindest regards,
  All of the LKST developers

----------------
  Yumiko Sugita
  Hitachi,Ltd., Systems Development Laboratory
  Email:sugita@sdl.hitachi.co.jp 

