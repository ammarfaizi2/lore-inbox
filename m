Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSBKNqo>; Mon, 11 Feb 2002 08:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289386AbSBKNqe>; Mon, 11 Feb 2002 08:46:34 -0500
Received: from bs1.dnx.de ([213.252.143.130]:42926 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S289377AbSBKNq1>;
	Mon, 11 Feb 2002 08:46:27 -0500
Date: Mon, 11 Feb 2002 14:45:58 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: New version (2.4.18-pre9.2) of AMD Elan patch
Message-ID: <Pine.LNX.4.33.0202111442060.24650-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new version of the AMD Elan patch is available on

  http://www.pengutronix.de/software/elan_en.html

This patch against 2.4.18-pre9 deals with the following stuff:

- serial driver bugfix (was sent to Theodore Ts'o)
- correct ioport resource reservation for /proc/ioport

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


