Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSETHoS>; Mon, 20 May 2002 03:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSETHoR>; Mon, 20 May 2002 03:44:17 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:26018 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S314325AbSETHoR>; Mon, 20 May 2002 03:44:17 -0400
Date: Mon, 20 May 2002 10:54:03 +0300 (EEST)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SO_TIMESTAMP
Message-ID: <Pine.LNX.4.33.0205201042320.5575-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Sorry to bother you guys but I have been looking on the net for docs and
couldnt find any. I am working on a echo-request/echo-reply based
monitoring tool for Linux and while browsing the iptools sources from
ftp.inr.ac.ru I noticed that the author does some magic (to me ;) ) with
a SO_TIMESTAMP value. I have been looking in the kernel sources for this
and it seems that 2.2.x doesnt have any SO_TIMESTAMP but 2.4.x have.

If someone would explain to me what it does and how can I use it for
accurate RTT values (or some URLs to the documentation about this).

Also the SIOCGSTAMP its not very well documented in the man pages, what
does this return exactly ? The timestamp of the last received packet by a
user process, any process, the running process ? :)

Thanks

----------------------------
Mihai RUSU

Disclaimer: Any views or opinions presented within this e-mail are solely
those of the author and do not necessarily represent those of any company,
unless otherwise specifically stated.

