Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283480AbRLDVEK>; Tue, 4 Dec 2001 16:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281180AbRLDVDp>; Tue, 4 Dec 2001 16:03:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29959 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281225AbRLDVCW>; Tue, 4 Dec 2001 16:02:22 -0500
Subject: Re: hints at modifying kswapd params in 2.4.16
To: sven@research.nj.nec.com (Sven Heinicke)
Date: Tue, 4 Dec 2001 21:11:24 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        sven@research.nj.nec.com (Sven Heinicke), linux-kernel@vger.kernel.org
In-Reply-To: <15373.13379.382015.406274@abasin.nj.nec.com> from "Sven Heinicke" at Dec 04, 2001 03:38:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BMqa-0003V2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The first system I tried was Red Hat 7.1, it never used more then 2G
> of cache memory leaving the other 2G free.
> 
> The other system, Mandrake 8.0, sucks up all the 4G of memory with
> cache but has not yet shown any signs of thrashing.  Though the code
> has only been running a few hours.

The RH 7.1 tree is 2.4.2-ac based and certainly wont behave well under some
loads.
