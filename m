Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAQMW2>; Fri, 17 Jan 2003 07:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTAQMW2>; Fri, 17 Jan 2003 07:22:28 -0500
Received: from [132.69.253.254] ([132.69.253.254]:6601 "HELO
	vipe.technion.ac.il") by vger.kernel.org with SMTP
	id <S265094AbTAQMW1>; Fri, 17 Jan 2003 07:22:27 -0500
Date: Fri, 17 Jan 2003 14:31:19 +0200 (IST)
From: Shlomi Fish <shlomif@vipe.technion.ac.il>
To: <linux-kernel@vger.kernel.org>
Subject: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Message-ID: <Pine.LNX.4.33L2.0301171425070.19816-100000@vipe.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LKMB version 0.1.16 is the humble codeware beginning of the CLAN project.
It is essentially a Perl package (proper with Makefile.PL and all, but not
CPANed yet), which enables one to process LKMB packages.

The latter ones are packages that LKMB can create installation and
compilation packages for kernel modules that can run in any enviornment
the Linux kernel can be compiled and installed on. (a GNU environment).

It contains an example module for the Ethernet DMFE module. Currently, the
makefile for the kernel module's package supports only the "all" and
"install" targets.

I will upload it to CPAN soon, but would like to get some initial feedback
beforehand.

Regards,

	Shlomi Fish


----------------------------------------------------------------------
Shlomi Fish        shlomif@vipe.technion.ac.il
Home Page:         http://t2.technion.ac.il/~shlomif/

He who re-invents the wheel, understands much better how a wheel works.

