Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUENRbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUENRbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUENRbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:31:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:40906 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261900AbUENRbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:31:35 -0400
X-Authenticated: #6327448
Message-ID: <005e01c439d9$12cc93a0$0201a8c0@venomlaptop>
From: "A_VeNoM" <a_venom@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: =?iso-8859-1?Q?bug_in_md.so_Line_1547_and_server_doesn=B4t_boot_anymore...?=
Date: Fri, 14 May 2004 19:29:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy all!

I got a problem on a mostly fresh installed server with the md.c

The server does not boot anymore (*cry* it lasted 4 days to install and
setup it)`

OS is SuSe Linux 9.0 with the 2.4.21-99-default Kernel and gcc version 3.3.1

It hangs with this Error Message on boot:

considerinr /dev/md0
/dev/md0 is not a RAID0 or LINEAR array, skipping.
[events: 000000009]
[events: 000000009]
md: autorun ...
md: considering sdb1 ...
md: adding sdb1 ...
md: adding sda1
md: created md0
md: bind<sda1,1>
md: bind<sda1,2>
md: running: <sdb1><sda1>
md: sdb1´s event counter 000000009
md: sda1´s event counter 000000009
md: device name has changed from sda1 to sdb1 since last import!^
md0: former device sdb1 is unavailable, removing from array!
md: bug in file md.c, line 1547

md:o**********************************************************
md:o* <COMPLETE RAID STATE PRINTOUT> *
md:o**********************************************************

Do you have any Idea how i can get the Server running again?

Thanks in advance!

VeNoM

