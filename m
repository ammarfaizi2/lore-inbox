Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSHLHTE>; Mon, 12 Aug 2002 03:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSHLHTE>; Mon, 12 Aug 2002 03:19:04 -0400
Received: from fc.capaccess.org ([151.200.199.53]:11012 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S317458AbSHLHTD>;
	Mon, 12 Aug 2002 03:19:03 -0400
Message-id: <fc.0010c7b20054c5020010c7b20054c502.54c557@Capaccess.org>
Date: Mon, 12 Aug 2002 03:23:18 -0400
Subject: report from left field
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built a simple 2.4.19 with gcc 3.0, and am writing from a warm boot
to it. The bletcherization of the kernel still hasn't completely killed
cLIeNUX. I do now have to run my pathname mungler on the kernel sources
themselves, which I didn't used to have to do, and make dep doesn't work
anyway, but make bzImage is almost hitch-free. 

You get a lot of questions about modules in make config after telling it
no modules. 
As usual I have a lot of drivers for things not on this box and all seems
rosy. It's big though. 900k without my usual "everything that doesn't kill
it", and of course, I boot an image with the System.map and .config
appended to the bzImage itself. 

Rick Hohensee
:; cLIeNUX /dev/tty4  02:48:45   /
:;d -d */
Ha3sm/       command/     device/      help/        owner/       suite/
Linux/       configure/   floppy/      log/         source/      temp/
boot/        dev/         guest/       mount/       subroutine/
:; cLIeNUX /dev/tty4  02:48:49   /
:;
o

