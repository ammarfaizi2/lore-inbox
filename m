Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUASIlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUASIlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 03:41:12 -0500
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:13022 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S264459AbUASIlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 03:41:09 -0500
Message-Id: <5.1.1.9.2.20040119173658.05206fe0@sdl99c>
X-Mailer: QUALCOMM Windows Eudora Version 5.1-Jr4
Date: Mon, 19 Jan 2004 17:43:10 +0900
To: linux-kernel@vger.kernel.org
From: Yumiko Sugita <sugita@sdl.hitachi.co.jp>
Subject: LKST v2.0.1 for Kernel 2.6.0 is released.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

    I'd like to announce publication of Linux Kernel State Tracer (LKST) 
version 2.0.1,
  which is a tracer for Linux kernel.

  LKST is a tool that supports to analyze of fault and evaluate for kernel.
Especially it is usuful for analyzing the unanticipated fault of kernal.

  LKST v2.0.1 is for Kernel version 2.6.0.
And platforms of LKST 2.0.1 are both IA32 and IA64.
#The details are described in changes-2.0.1.txt.

Remarks:
   For supporting IA64, we changed some codes in the following programs.
   - KernelHooks


    LKST binaries, source code and documents are available in the following site,
         https://sourceforge.net/projects/lkst/
         http://sourceforge.jp/projects/lkst/

    We prepared a mailing list written below in order to let users know 
update of LKST.

  lkst-users@lists.sourceforge.net
  lkst-users@lists.sourceforge.jp

  To subscribe, please refer following URL,

  http://lists.sourceforge.net/lists/listinfo/lkst-users
  http://lists.sourceforge.jp/mailman/listinfo/lkst-users

    And if you have any comments, please send to the above list, or to 
another mailing-list written below.

  lkst-develop@lists.sourceforge.net
  lkst-develop@lists.sourceforge.jp

  With kindest regards,
  All of the LKST developers

----------------
  Yumiko Sugita
  Hitachi,Ltd., Systems Development Laboratory
  E-mail: sugita@sdl.hitachi.co.jp 

