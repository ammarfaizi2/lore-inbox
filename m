Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUFRKhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUFRKhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUFRKhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:37:48 -0400
Received: from mail.gbg.bostream.net ([81.26.226.10]:38101 "EHLO
	mail.gbg.bostream.net") by vger.kernel.org with ESMTP
	id S265094AbUFRKhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:37:46 -0400
Date: Fri, 18 Jun 2004 12:37:44 +0200 (CEST)
From: Thorsten Rhau <t-r@swipnet.se>
X-X-Sender: readmail@x.home
To: linux-kernel@vger.kernel.org
Subject: MISSING: CONFIG_IDEDISK_STROKE
Message-ID: <Pine.LNX.4.58.0406181229500.4837@x.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have been using the 2.6.x series kernels sence 2.6.2 and everything just
worked fine for me, great job!

A few days ago the 2.6.7 kernel was released and of course i tried to
install it on my system. My problem is that i am not able to find
"Auto-Geometry Resizing support" in make menuconfig. I think that this
parameter is called CONFIG_IDEDISK_STROKE in the .config file. I am not
able to find it in the .config either ...........

I have tried to locate information about this in the release notes for the
2.6.7 kernel and on http://www.lkml.org without success.

best regards
/thorsten

root@x:/usr/src/linux-2.6.7# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux x 2.6.6 #1 Mon May 10 14:06:17 CEST 2004 i686 unknown unknown
GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
binutils               2.14.90.0.6
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
root@x:/usr/src/linux-2.6.7#
