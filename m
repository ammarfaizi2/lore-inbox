Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRALRxr>; Fri, 12 Jan 2001 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRALRxi>; Fri, 12 Jan 2001 12:53:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4627 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129595AbRALRxZ>; Fri, 12 Jan 2001 12:53:25 -0500
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 12 Jan 2001 17:54:24 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), cowboy@vnet.ibm.com (Richard A Nelson),
        sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg),
        ak@suse.de (Andi Kleen), linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.10.10101120931520.1806-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 12, 2001 09:35:14 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14H8PC-0004hZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact that 2.2.x has bad control over capabilities and is messy is NOT
> an excuse to screw up forever. 

2.2 has a mix of 'can I use' and 'does the cpu have' so using 2.2 as an 
example doesnt work

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
