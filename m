Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRBTNL4>; Tue, 20 Feb 2001 08:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBTNLr>; Tue, 20 Feb 2001 08:11:47 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12805 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129213AbRBTNLc>; Tue, 20 Feb 2001 08:11:32 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14994.27891.171934.348706@wire.cadcamlab.org>
Date: Tue, 20 Feb 2001 07:11:15 -0600 (CST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
In-Reply-To: <20010219230106.A23699@cadcamlab.org>
	<E14VBBn-0006Q5-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Cox]
> There is an assumption in the kernel that only the task changes its
> own uid and other related data.

Fair enough but could you explain the potential problems?  And how is
it different from sys_setpriority?

Peter
