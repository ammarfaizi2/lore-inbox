Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281652AbRLDSPd>; Tue, 4 Dec 2001 13:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283243AbRLDSOV>; Tue, 4 Dec 2001 13:14:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34821 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281527AbRLDSMw>; Tue, 4 Dec 2001 13:12:52 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: cate@dplanet.ch (Giacomo Catenazzi)
Date: Tue, 4 Dec 2001 18:21:15 +0000 (GMT)
Cc: Wayne.Brown@altec.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C0D0BFD.6080903@dplanet.ch> from "Giacomo Catenazzi" at Dec 04, 2001 06:46:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BKBw-0002xO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make bzlilo modules modules_install: it would be a simble
> make install: (and you configure with CML1/CML2 what install
> means).

How does it handle that when install means different things on each box of
a set of them NFS sharing the kernel tree. This is a real world example
