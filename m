Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUKROSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUKROSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUKROSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:18:18 -0500
Received: from mail6.hitachi.co.jp ([133.145.228.41]:7906 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S262020AbUKROSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:18:12 -0500
Message-ID: <419CAF77.5010208@sdl.hitachi.co.jp>
Date: Thu, 18 Nov 2004 23:19:35 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE/LKST] LKST 2.2.0 for linux-2.6.9 is released.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

We are pleased to announce releasing new version of Linux Kernel State
Tracer.

The Linux Kernel State Tracer(a.k.a. LKST) version 2.2.0 has been
released. This version can be applied to linux-2.6.9. And LKST 2.2.0
supports IA32, IA64 and x86-64 platforms.

LKST is a tool that supports to analyze of fault and evaluate for kernel.
Especially it is usuful for analyzing the unanticipated fault of kernal.

The latest version of the LKST newly supports the x86-64 architecture.

For more changes, see Changelog-2.2.0.txt
<http://prdownloads.sourceforge.net/lkst/Changelog-2.2.0.txt?download>

Remarks:
For supporting IA64 and x86-64, we hacked KernelHooks.

LKST binaries, source code and documents are available in the following
site,
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

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
  E-mail: hiramatu@sdl.hitachi.co.jp
