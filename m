Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRCABNv>; Wed, 28 Feb 2001 20:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRCABNk>; Wed, 28 Feb 2001 20:13:40 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:38674 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129401AbRCABN1>; Wed, 28 Feb 2001 20:13:27 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15005.41522.953012.787794@wire.cadcamlab.org>
Date: Wed, 28 Feb 2001 19:13:22 -0600 (CST)
To: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
Cc: <linux-kernel@vger.kernel.org>, <linux-kbuild@torque.net>
Subject: Re: [kbuild-devel] [PATCH] Makefile fixes
In-Reply-To: <Pine.LNX.4.30.0102282323060.30937-100000@vaio>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Kai Germaschewski]
> +list-multi	:= fore_200e
> +fore_200e-objs	:= fore200e.o $(FORE200E_FW_OBJS)

   list-multi	:= fore_200e.o

Peter
