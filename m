Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSE3Tet>; Thu, 30 May 2002 15:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSE3Ter>; Thu, 30 May 2002 15:34:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64445 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316845AbSE3Ten>; Thu, 30 May 2002 15:34:43 -0400
Date: Thu, 30 May 2002 21:34:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE][PATCH] atapci 0.50
Message-ID: <Pine.SOL.4.30.0205302128001.1462-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

user-space tool to get info from ATA pci chipsets
(rewritten ide-info)
has all functionality of latest 2.5.x/2.4.x plus
- getting info from multiple identical cards
- simulation of ATA timings with changed PCI bus speed

http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-0.50.tar.bz2


patch to remove dead and now obsolete code from 2.5.19:

http://home.elka.pw.edu.pl/~bzolnier/atapci/atapci-proc-rm.diff

--
bkz

