Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSBMNzj>; Wed, 13 Feb 2002 08:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284264AbSBMNz3>; Wed, 13 Feb 2002 08:55:29 -0500
Received: from [200.176.117.26] ([200.176.117.26]:26100 "EHLO
	webserver.senior.com.br") by vger.kernel.org with ESMTP
	id <S283003AbSBMNzW>; Wed, 13 Feb 2002 08:55:22 -0500
Message-ID: <109DE52B4717D611A85400C0DFB0556E2123A1@WEBSERVER>
From: Carlo <carlo@senior.com.br>
To: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Problem with menuconfig after installation of IPSec ( FreeS/WAN )
Date: Wed, 13 Feb 2002 11:56:06 -0300
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After install of FreeS/WAN 1.95 ( IPSec )   ( make menugo ) , when I try to
select Networking Options from menuconfig, the following screen apears...

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> scripts/Menuconfig: MCmenu7: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1

I am running kernel 2.2.19 on Slackware 8 distro 

What can I do ? 


