Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbTJDJYr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTJDJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:24:47 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:54694 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261964AbTJDJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:24:45 -0400
Date: Sat, 4 Oct 2003 05:24:56 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: error configuring for ARCH=arm
Message-ID: <Pine.LNX.4.44.0310040522400.687-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  as a first attempt in building a cross-compile toolchain
for my ARM-based sharp zaurus, i started with a clean 2.6.0-bk5
source tree and ran:

$ make ARCH=arm xconfig
make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/qconf arch/arm/Kconfig
file net/bluetooth/Kconfig already scanned?
make[1]: *** [xconfig] Error 1
make: *** [xconfig] Error 2


  any thoughts?

rday

