Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129473AbQKSN2B>; Sun, 19 Nov 2000 08:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129717AbQKSN1v>; Sun, 19 Nov 2000 08:27:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129473AbQKSN1d>; Sun, 19 Nov 2000 08:27:33 -0500
Subject: Re: Linux 2.2.18pre22
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Sun, 19 Nov 2000 12:57:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001119015303.A25697@vger.timpanogas.org> from "Jeff V. Merkey" at Nov 19, 2000 01:53:03 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xU2L-0002i3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	Fix file/block when spacing to tape beginning	(Kai Maiksara)
> > o	Small ISDN documentation fixes			(Kai Germaschewski)
> 
> Alan, On the ISDN issue, isdn4K-utils seems to be out of sync with=20
> kernels older than 2.2.16.   Some #define's that used to be in
> the 2.2.14 patch don't seem to be in 2.2.17 >.  At present, requires
> an ugly .config patch to work under 2.2.18-21. =20

Shouldn't do. ISDN has changed between 2.2.16 and 2.2.18pre22 but not in any
way I am aware is bad. 2.2.19 has the merge of the rest of the isdn changes
queued.

(ps: please use the delete key to delete un-needed stuff in replies)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
