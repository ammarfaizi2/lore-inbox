Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSEHEzu>; Wed, 8 May 2002 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315526AbSEHEzt>; Wed, 8 May 2002 00:55:49 -0400
Received: from pD952A78A.dip.t-dialin.net ([217.82.167.138]:11175 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315525AbSEHEzs>; Wed, 8 May 2002 00:55:48 -0400
Date: Tue, 7 May 2002 22:55:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: jfs_mount.o: weird gcc behavior
Message-ID: <Pine.LNX.4.44.0205072253070.19544-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when compiling fs/jfs/jfs_mount.c, gcc 2.95.2 keeps issuing 
"../../gcc/caller-save:657: Internal compiler error in function 
insert_save_restore". Unfortunately I'm unable to compile myself another 
version of gcc, hell knows why...

Regards,
Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

