Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbULENib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbULENib (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbULENib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 08:38:31 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:4876 "EHLO
	globaledgesoft.com") by vger.kernel.org with ESMTP id S261301AbULENi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 08:38:29 -0500
Message-ID: <41B30ECB.8070907@globaledgesoft.com>
Date: Sun, 05 Dec 2004 19:06:11 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: UML debugging session
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 172.16.6.42
X-Return-Path: krishna.c@globaledgesoft.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I installed UML on my system.
I am not able to use it properly for debugging,

linux-2.4.26# gdb linux
GNU gdb 5.3
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain 
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-slackware-linux"...
(gdb) att 1
Attaching to program: /root/Desktop/UML/new/linux-2.4.26/linux, process 1
ptrace: Operation not permitted.
(gdb) b start_kernel
Breakpoint 1 at 0xa0002447: file init/main.c, line 362.

Regards,
Krishna Chaitanya

