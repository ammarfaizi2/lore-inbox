Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbRF2QOT>; Fri, 29 Jun 2001 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266113AbRF2QOJ>; Fri, 29 Jun 2001 12:14:09 -0400
Received: from pD900F05C.dip.t-dialin.net ([217.0.240.92]:49926 "EHLO
	neon.hh59.org") by vger.kernel.org with ESMTP id <S266108AbRF2QOB>;
	Fri, 29 Jun 2001 12:14:01 -0400
Date: Fri, 29 Jun 2001 18:14:07 +0200 (CEST)
From: <axel@hh59.org>
To: "linux-kernel.ml" <linux-kernel@vger.kernel.org>
cc: <mec@shout.net>
Subject: make menuconfig error
Message-ID: <Pine.LNX.4.33.0106291812130.5446-100000@neon.hh59.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i encountered following err during make menuconfig/net device/10mbitcards
selection.

axel

---
Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu31: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
---

