Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262941AbSJBC6k>; Tue, 1 Oct 2002 22:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262942AbSJBC6k>; Tue, 1 Oct 2002 22:58:40 -0400
Received: from dns2.rocler.qc.ca ([204.101.179.31]:3251 "EHLO
	chekov.rocler.qc.ca") by vger.kernel.org with ESMTP
	id <S262941AbSJBC6j>; Tue, 1 Oct 2002 22:58:39 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: chekov.rocler.qc.ca
Posted-Date: Tue, 1 Oct 2002 23:03:26 -0400
Subject: make: *** [menuconfig] Error 1
From: Nicolas Bouliane <linuxaide.net@rocler.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Oct 2002 23:01:06 -0400
Message-Id: <1033527666.3990.6.camel@skullbox>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I :)

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
root@skullbox:/usr/src/linux-2.5.40# make menuconfig

---------
Kernel version 2.5.40, downloaded today ( october first ) from 
kernel.org.

the menu

Sound  --->  
	Advanced Linux Sound Architecture  --->

seem to be buggy;/
----------

thank ya!



