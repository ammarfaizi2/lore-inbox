Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131094AbRAKA6w>; Wed, 10 Jan 2001 19:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAKA6d>; Wed, 10 Jan 2001 19:58:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30471 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129584AbRAKA6V>; Wed, 10 Jan 2001 19:58:21 -0500
Subject: Re: [PATCH] 2.2.18pre21 ide-disk.c for OB800
To: andre@linux-ide.org (Andre Hedrick)
Date: Thu, 11 Jan 2001 00:15:58 +0000 (GMT)
Cc: grundler@cup.hp.com (Grant Grundler), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, taggart@fc.hp.com, m.ashley@unsw.edu.au
In-Reply-To: <Pine.LNX.4.10.10101101517290.26053-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 10, 2001 03:18:22 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14GVPN-0001Iu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrong method.
> 
> APMD has to have the ablity to remember the state.
> Spindown is basically a power reset to the drive.

Wrong answer, apmd if its swapped out doesnt get back in on some drives

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
