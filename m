Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316354AbSEOJ4B>; Wed, 15 May 2002 05:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316361AbSEOJ4A>; Wed, 15 May 2002 05:56:00 -0400
Received: from jack.stev.org ([217.79.103.51]:47607 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S316354AbSEOJ4A>;
	Wed, 15 May 2002 05:56:00 -0400
Message-ID: <014801c1fbf6$fbae5f40$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@ez-dsp.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3c59x.c in 2.4.19-pre8
Date: Wed, 15 May 2002 10:57:54 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i had a few problems with the 3c59x driver over the last
few days.

I have a
00:0a.0: 3Com PCI 3c905C Tornado at 0xd800.

Which has been working fine for a few months.
i updated the kernel to 2.4.19-pre8 for
the ide promise ata/133 card.
no problem works fine.

So the 3c59x.c card was working to
though it did have a bad performance problem.
looking at ifconfig said it had alot of tx carrier
errors (70% of packets ) becaus i had moved the machine etc..
i check the cables etc.. all seem fine.

so i dropped the driver back to the one in 2.4.18 and all
seems fine again.

anyone any ideas ?

    James









