Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVCVCoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVCVCoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCVCnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:43:09 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:26575 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S262289AbVCVCBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:01:20 -0500
Message-ID: <423F7CC3.599ABE5D@sdl.hitachi.co.jp>
Date: Tue, 22 Mar 2005 11:02:43 +0900
From: sugita <sugita@sdl.hitachi.co.jp>
X-Mailer: Mozilla 4.78 [ja] (Windows NT 5.0; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: lkst-develop@lists.sourceforge.net
Subject: Disk Allocation Viewer (dav) is released
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

We are pleased to announce releasing the new function,
Disk Allocation Viewer (a.k.a. dav).

---
The development of this program is partly supported by IPA
(Information-Technology Promotion Agency, Japan).
---

dav is a program which collects and visualizes the fragmentation
status information of Linux filesystem, ext2/ext3. dav can collect
the fragmentation status information regardless of whether
filesystem is mounted, and can output its text data or visualize it.
Please use this tool and give us some comment.

The following software is necessary for the compilation and the
execution of dav.
 - Linux kernel v2.4 / v2.6
 - GTK+1.2

---
dav binaries, source code and documents are
available in the following site,
http://sourceforge.net/projects/davtools/
http://sourceforge.jp/projects/dav/

We prepared a mailing list written below in order to let users know
update of dav.
 dav-users@lists.sourceforge.jp
 davtools-users@lists.sourceforge.net

And if you have any comments, please send to the above list, or to
another mailing-list written below.
 davtools-develop@lists.sourceforge.net
 dav-develop@lists.sourceforge.jp

Best regards,
All of the dav developers
-----------------
Yumiko Sugita
Hitachi,Ltd., Systems Development Laboratory
E-mail: sugita@sdl.hitachi.co.jp


