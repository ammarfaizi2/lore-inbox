Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSBCN64>; Sun, 3 Feb 2002 08:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSBCN6q>; Sun, 3 Feb 2002 08:58:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287189AbSBCN6a>; Sun, 3 Feb 2002 08:58:30 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: ralf@uni-koblenz.de (Ralf Baechle)
Date: Sun, 3 Feb 2002 13:40:16 +0000 (GMT)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        davem@redhat.com (David S. Miller), vandrove@vc.cvut.cz,
        torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com
In-Reply-To: <20020203080134.C19813@dea.linux-mips.net> from "Ralf Baechle" at Feb 03, 2002 08:01:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XMsS-0004TM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it really worth the effort?  During the past year the average size of
> embedded systems that people want to use for seems to have increased
> dramatically.  In case of the MIPS port the core activity is about to
> move away from the 32-bit to 64-bit kernel.

Embedded system and fancy handheld toys are not really the same thing. One
subset of the market gets cheaper the other gets flashier and more high
powered.

Mips is now dead in the handheld market if windows ce drops it.

