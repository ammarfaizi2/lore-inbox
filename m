Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132272AbRAGNyt>; Sun, 7 Jan 2001 08:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRAGNyj>; Sun, 7 Jan 2001 08:54:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47886 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132272AbRAGNyT>; Sun, 7 Jan 2001 08:54:19 -0500
Subject: Re: 2.2.18:  your CPUs had inconsistent variable MTRR setting
To: hklygre@online.no (Haavard Lygre)
Date: Sun, 7 Jan 2001 13:56:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3lmsnvojx.fsf@frode.valhall.no> from "Haavard Lygre" at Jan 07, 2001 07:55:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGJ5-0002gH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During boot of 2.2.18 I get the following messages:
> 
> mtrr: your CPUs had inconsistent variable MTRR settings
> mtrr: probably your BIOS does not setup all CPUs
> 
> Is this something I should worry about?

It means your bios vendor cannot read specifications. Linux fixed up the problem.
I wouldnt worry too much BIOS vendors don't believe in specifications 8)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
