Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTGKQeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTGKQe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:34:29 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:3591 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264192AbTGKQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:34:22 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.22-pre4] rmap15j + all BK fixes/adds
Date: Fri, 11 Jul 2003 18:48:31 +0200
User-Agent: KMail/1.5.2
Cc: Rik van Riel <riel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307111747.57211.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

at the link below you can find rmap15j + all BK fixes/adds for 2.4.22-pre4. 
I've done this because rmap is my favorite VM and I want to support it where 
I can, and this is just a "Tons of users want to use bleeding edge -pre's so 
give them a very good VM" ;)

Have fun.

P.S.: The only part I was unsure about is the s390x init.c stuff.
      I've also included .22-BK mainline cset 1.1086 which is a showstopper.
      I've not attached the patch to this mail because it's kinda large.

Compiles, boots, works [tm] on my x86 machine :)

- Linux codeman 2.4.22-pre4-rmap15j #1 Fri Jul 11 18:16:38 CEST 2003 i686
- gcc version 3.3.1 20030626 (Debian prerelease)


URL:
----
http://wolk.sf.net/tmp/linux-2.4.22-pre4-rmap15j+bkfixes.patch

md5sum:
-------
0c39e54f1b3af8f076fdbe7669439e40

ciao, Marc

