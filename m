Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281320AbRKPLvj>; Fri, 16 Nov 2001 06:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281317AbRKPLv3>; Fri, 16 Nov 2001 06:51:29 -0500
Received: from mustard.heime.net ([194.234.65.222]:44208 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281313AbRKPLvM>; Fri, 16 Nov 2001 06:51:12 -0500
Date: Fri, 16 Nov 2001 12:51:07 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: Tuning Linux for high-speed disk subsystems
In-Reply-To: <20011116025639Z281196-17408+14879@vger.kernel.org>
Message-ID: <Pine.LNX.4.30.0111161249440.17531-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our 100 Gig SCSI raid, consisting of 6 15,000 rpm drives on the motherboard's
> two SCSI 160 channels gives a full 110MB/sec read and write with RAID 0. With
> RAID chunks set to 1MB the write accesses go to 160MB/sec and read accesses
> go to 90MB/sec sustained. This system would make a good motion capture tool.
> Previous Intel attempts at onboard disk I/O would give 50MB/sec.

How much do you think I can get out of 2x6 15k disks - each 6 disks are on
their own SCSI-3/160 bus.
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

