Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbSJFE6z>; Sun, 6 Oct 2002 00:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbSJFE6z>; Sun, 6 Oct 2002 00:58:55 -0400
Received: from fugazi.engr.arizona.edu ([150.135.83.155]:7413 "EHLO
	fugazi.engr.arizona.edu") by vger.kernel.org with ESMTP
	id <S263340AbSJFE6y>; Sun, 6 Oct 2002 00:58:54 -0400
Date: Sat, 5 Oct 2002 22:06:57 -0700 (MST)
From: Tim Spriggs <tims@fugazi.engr.arizona.edu>
To: mec@shout.net
cc: linux-kernel@vger.kernel.org
Subject: make menuconfig problem
Message-ID: <Pine.GSO.4.44.0210052202560.21630-100000@fugazi.engr.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I got this when I selected the alsa branch of the kernel configuration
with kernel 2.5.40:

| Menuconfig has encountered a possible error in one of the kernel's
| configuration files and is unable to continue.  Here is the error
| report:
|
|  Q> ./scripts/Menuconfig: line 823: MCmenu74: command not found
|
| Please report this to the maintainer <mec@shout.net>.  You may also
| send a problem report to <linux-kernel@vger.kernel.org>.
|
| Please indicate the kernel version you are trying to configure and
| which menu you were trying to enter when this error occurred.
|
| make: *** [menuconfig] Error 1
|

If there is anything I can do to help fix this, let me know.

-Tim

                     < PRE >
##--##--##--##--##--##--##--##--##--##--##--##--##
|             T I M    S P R I G G S             |
|        Assistant Sysadmin - Development        |
|        College of Engineering and Mines        |
|            ECE206A - (520) 621-3185            |
##--##--##--##--##--##--##--##--##--##--##--##--##
                     </PRE >

