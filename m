Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRAaPXc>; Wed, 31 Jan 2001 10:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbRAaPXM>; Wed, 31 Jan 2001 10:23:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65031 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129655AbRAaPXC>; Wed, 31 Jan 2001 10:23:02 -0500
Subject: Re: CPU error codes
To: jas88@cam.ac.uk (James Sutherland)
Date: Wed, 31 Jan 2001 15:23:16 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jsimmons@suse.com (James Simmons),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.SOL.4.21.0101250913590.15936-100000@orange.csi.cam.ac.uk> from "James Sutherland" at Jan 25, 2001 09:14:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Nz6N-0002Vj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In the intel databook. Generally an MCE indicates hardware/power/cooling
> > issues
> 
> Doesn't an MCE also cover some hardware memory problems - parity/ECC
> issues etc?

Parity/ECC on main memory is reported by the chipset and needs seperate
drivers or apps to handle this
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
