Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272232AbTG3Uf1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTG3Uf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 16:35:27 -0400
Received: from mail2.webspace.se ([213.88.151.136]:25517 "HELO
	mail2.webspace.se") by vger.kernel.org with SMTP id S272232AbTG3UfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 16:35:21 -0400
Message-ID: <4313.195.198.219.153.1059597317.squirrel@213.88.151.235>
Date: Wed, 30 Jul 2003 22:35:17 +0200 (CEST)
Subject: 
From: bylzz@orkan.net
To: mec@shout.net
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The kernel config error report told me to send a mail.

When I want to enter:

ATA/IDE/MFM/RLL support  --->

The following happends: menuconfig crashes and gives me this:

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu23: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

Have compiled kernels atleast 60 times and never encounterd any problems,
so this seems to be strange. Thought that this error is the couse of me
getting error when doing 'make dep' and that returns errors to.

./bylzz


