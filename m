Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEPDB>; Fri, 5 Jan 2001 10:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAEPCl>; Fri, 5 Jan 2001 10:02:41 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:33267 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S129267AbRAEPCd>;
	Fri, 5 Jan 2001 10:02:33 -0500
Message-ID: <3A55E203.20B42B78@sls.lcs.mit.edu>
Date: Fri, 05 Jan 2001 10:02:27 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Lee Hetherington <ilh@sls.lcs.mit.edu>
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54E717.11A43B42@sls.lcs.mit.edu> <3A557D12.A5383794@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to follow up, but I forgot to note that it is trying to share IRQ
11 for aic7xx and eth0.  However, even if I move the Adaptec card to
another slot, where it gets IRQ 10, still no joy for eth0 on IRQ 11.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
