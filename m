Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVCVCoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVCVCoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVCVCnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:43:35 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:26319 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S262288AbVCVCBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:01:20 -0500
Message-ID: <423F7CC2.305883C1@sdl.hitachi.co.jp>
Date: Tue, 22 Mar 2005 11:02:42 +0900
From: sugita <sugita@sdl.hitachi.co.jp>
X-Mailer: Mozilla 4.78 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: lkst-develop@lists.sourceforge.net
Subject: The new function of LKST is released
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

 We are pleased to announce releasing new function of Linux
Kernel State Tracer(a.k.a. LKST).
 It's a lkstlogtools for analyzing performance of kernel.
This function is released as lkstlogtools v1.0.1.
For using this function, LKST v2.2.1 is needed.
Please use this tool and give us some comment.

---
The development of this program is partly supported by IPA
(Information-Technology Promotion Agency, Japan).
---

 LKST with lkstlogtools can collect the queue information and
the execution time of some key processing and analyze them.
lkstlogtools provides some tools for analyzing and visualizing LKST
data too.
>From these analyzed data, user can know what processing is slow
and the status of the queue at the time.
Thus user can use LKST with lkstlogtools as a tool to evaluate
kernel performance.

---
lkstlogtools and LKST binaries, source code and documents are
available in the following site,
http://sourceforge.net/projects/lkst/
http://sourceforge.jp/projects/lkst/

We prepared a mailing list written below in order to let users know
update of LKST.
 lkst-users@lists.sourceforge.net
 lkst-users@lists.sourceforge.jp

And if you have any comments, please send to the above list, or to
another mailing-list written below.
 lkst-develop@lists.sourceforge.net
 lkst-develop@lists.sourceforge.jp

Best regards,
All of the LKST developers
-----------------
Yumiko Sugita
Hitachi,Ltd., Systems Development Laboratory
E-mail: sugita@sdl.hitachi.co.jp

