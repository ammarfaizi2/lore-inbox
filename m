Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269388AbTCDLs2>; Tue, 4 Mar 2003 06:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269389AbTCDLs2>; Tue, 4 Mar 2003 06:48:28 -0500
Received: from dsl-212-144-227-177.arcor-ip.net ([212.144.227.177]:43136 "EHLO
	VikingPC.home") by vger.kernel.org with ESMTP id <S269388AbTCDLs1>;
	Tue, 4 Mar 2003 06:48:27 -0500
Date: Tue, 4 Mar 2003 12:58:55 +0100
From: Corvus Corax <corvusvcorax@gemia.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] optional hardcoded kernel command line i386, x86_64
 linux-2.4.20
Message-Id: <20030304125855.61497226.corvusvcorax@gemia.de>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003.03.04 -- cmdline-linux-2.4.20.patch
This patch provides an optional hardcoded kernel command line
along with with specifyable override behaviour
against the command line provided by the bootloader (if any)
written for arch/i386 and arch/x86_64 in linux-2.4.20
by Eric Noack (Corvus V Corax) <corvusvcorax@gemia.de>

I have seen this feature as a patch for >= 2.5.x , but missed it for
linux 2.4.x, so i just wrote it, maybe there is already one,
which I missed, so just take the better ;-)
I guess it might be useful for floppy boot, but it needs testing
at least on the x86_64 architecture, i dont have one of these yet


patch is at

http://gemia.de/test/cmdline-patch.tgz
			\ README
			\ cmdline-linux-2.4.20.patch

please tell me if there are any problems with it, would you? ;)
have fun ...
 
Corvus Corax
(aka Eric Noack)
