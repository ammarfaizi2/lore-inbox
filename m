Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265958AbRGFEhJ>; Fri, 6 Jul 2001 00:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264965AbRGFEhA>; Fri, 6 Jul 2001 00:37:00 -0400
Received: from mnh-1-26.mv.com ([207.22.10.58]:59396 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265958AbRGFEgs>;
	Fri, 6 Jul 2001 00:36:48 -0400
Message-Id: <200107060551.AAA02299@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.43-2.4.6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Jul 2001 00:51:40 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.6 is available.

Many bugs have been fixed, including a number of hangs and crashes.

The network helper is more helpful, especially for ethertap.

hostfs now supports device nodes

64-bit IO is now supported by the ubd driver and hostfs

There is now a management console, which is a low-level interface into the 
kernel - it allows the machine to be forcibly halted and allows disks to be 
added to and removed from a running system, see http://user-mode-linux.sourcefo
rge.net/mconsole.html for the details.

If you're not installing the RPM, you should update the userspace tools from 
CVS, especially uml_net (tools/uml_net/) and uml_mconsole (tools/mconsole).

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://sourceforge.net/project/filelist.php?group_id=429
	ftp://ftp.nl.linux.org/pub/uml/
	http://uml-pub.ists.dartmouth.edu/uml/

				Jeff


