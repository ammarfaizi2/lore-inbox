Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289537AbSBKNvE>; Mon, 11 Feb 2002 08:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSBKNuy>; Mon, 11 Feb 2002 08:50:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289492AbSBKNuw>; Mon, 11 Feb 2002 08:50:52 -0500
Subject: Re: kernel panic - bug or Hardware ?
To: shanti@mojo.cc.I ("sHANT) (")
Date: Mon, 11 Feb 2002 14:04:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200202111438.15602@@kosh.mojo.cc> from "sHANT)I(" at Feb 11, 2002 02:39:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aH4N-0006iG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i run a quad-cpu netserver (64MB parityRAM , 2x onboard Adaptec aic7870 SCSI adapter) under  Debian potato with 2.2.x kernel
> without any problem , but had to compile 2.4.17 for getting my Promise-Fastrack66-controller to work .. and since i run on 2.4 i 
> get strange kernel panic (totally random in time and action) with always the same trace.
> For i really have no idea on kernel debugging, i hope that i am right listed here to find help

Hard to tell (you've attached the right things but they dont provide much of
an answer other than 'crap happened').

You say you had to built this to get your fasttrack card working. If you run
without the fasttrak card in use (as you did in 2.2) does the box do this ?
