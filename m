Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317890AbSGKTmD>; Thu, 11 Jul 2002 15:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSGKTmC>; Thu, 11 Jul 2002 15:42:02 -0400
Received: from centauri.artland.com.pl ([62.233.164.19]:45443 "EHLO
	centauri.artland.com.pl") by vger.kernel.org with ESMTP
	id <S317890AbSGKTmA>; Thu, 11 Jul 2002 15:42:00 -0400
Date: Thu, 11 Jul 2002 21:23:57 +0200
To: linux-kernel@vger.kernel.org
Subject: compilation of floppy as module failure
Message-ID: <20020711192357.GA3722@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: =?iso-8859-1?Q?Micha=B3_Adamczak?= <pokryfka@druid.if.uj.edu.pl>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just wanted to report that in 2.4.19-rc1
the kernel image does not compile if floppy (CONFIG_BLK_DEV_FD) is 
to be compiled as a module.

the problem does not exist when the floppy is built in.

the listing of the ver_linux:

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12

-- 
Michal Adamczak
pokryfka@druid.if.uj.edu.pl

