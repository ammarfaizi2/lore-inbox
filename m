Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSECRKw>; Fri, 3 May 2002 13:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314838AbSECRKw>; Fri, 3 May 2002 13:10:52 -0400
Received: from barrichello.cs.ucr.edu ([138.23.169.5]:1939 "HELO
	barrichello.cs.ucr.edu") by vger.kernel.org with SMTP
	id <S314835AbSECRKv>; Fri, 3 May 2002 13:10:51 -0400
Date: Fri, 3 May 2002 10:10:42 -0700 (PDT)
From: John Tyner <jtyner@cs.ucr.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Subject: [PATCH] Add license string to sisfb
Message-ID: <Pine.LNX.4.30.0205031004470.26442-100000@hill.cs.ucr.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS perl-6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following adds a license string to the sisfb module. I haven't been
able to find a reference to a license for this module, so I just put GPL.
I hope this is correct.

Patch is made against 2.4.19-pre7, should apply to 2.5.

--- drivers/video/sis/sis_main.c.orig	Fri May  3 10:00:27 2002
+++ drivers/video/sis/sis_main.c	Fri May  3 10:00:54 2002
@@ -3092,3 +3092,4 @@

 EXPORT_SYMBOL(ivideo);

+MODULE_LICENSE("GPL");

