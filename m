Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSD0TmI>; Sat, 27 Apr 2002 15:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314433AbSD0TmH>; Sat, 27 Apr 2002 15:42:07 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:18955 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S314420AbSD0TmG>;
	Sat, 27 Apr 2002 15:42:06 -0400
Message-ID: <001501c1ee23$98c57cf0$0201a8c0@witek>
From: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
To: <linux-kernel@vger.kernel.org>
Subject: ext2 fs corruption on 2.5.10
Date: Sat, 27 Apr 2002 21:41:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 machines, 2 partitions:
At first kernel hanged while calling hdparm, after removing hdparm from rc
scripts, it hangs while remounting rootfs read-write. After that, partition
is totally screwed up. All parts (ide, ext2) compiled as modules.
It's reproductible but I'm unable to reproduce it since I'm cutted out from
my Linux partition
WK

