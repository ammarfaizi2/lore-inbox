Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJCSpy>; Thu, 3 Oct 2002 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbSJCSpy>; Thu, 3 Oct 2002 14:45:54 -0400
Received: from r42h20.res.gatech.edu ([128.61.42.20]:896 "EHLO
	earl.headnut.org") by vger.kernel.org with ESMTP id <S261274AbSJCSpx>;
	Thu, 3 Oct 2002 14:45:53 -0400
Date: Thu, 3 Oct 2002 14:50:17 -0400 (EDT)
From: root <root@earl.headnut.org>
To: <mec@shout.net>
cc: <linux-kernel@vger.kernel.org>
Subject: problem with 'make menuconfig'
Message-ID: <Pine.LNX.4.33.0210031449090.9729-100000@earl.headnut.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started beta testing 2.5.40 today, and when I tried to compile, I got 
this error message:


Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:

 Q> ./scripts/Menuconfig: MCmenu74: command not found

Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Error 1
[root@earl linux-2.5]#

