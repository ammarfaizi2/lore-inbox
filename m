Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288012AbSBNJAL>; Thu, 14 Feb 2002 04:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289655AbSBNJAB>; Thu, 14 Feb 2002 04:00:01 -0500
Received: from bs1.dnx.de ([213.252.143.130]:14272 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S288012AbSBNI7r>;
	Thu, 14 Feb 2002 03:59:47 -0500
Date: Thu, 14 Feb 2002 09:59:17 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: New version (2.4.18-rc1.1) of AMD Elan patch
Message-ID: <Pine.LNX.4.33.0202140958290.24650-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of the AMD Elan patch is available on

  http://www.pengutronix.de/software/elan_en.html

This patch against 2.4.18-rc1 deals with the following stuff:

- serial driver bugfix (was sent to Theodore Ts'o)
- correct ioport resource reservation for /proc/ioport

There are no changes since the last patch for 2.4.18-pre9.

If you have an AMD Elan processor (SC400, SC410, SC520) please test this
fix extensively and send me bug reports. You might also want to test it if
you don't have this special hardware, as the patch now does also affect
the normal serial driver.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+



