Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266742AbRGFPtb>; Fri, 6 Jul 2001 11:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266743AbRGFPtU>; Fri, 6 Jul 2001 11:49:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15123 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266742AbRGFPtG>; Fri, 6 Jul 2001 11:49:06 -0400
Subject: Re: DMA memory limitation?
To: sp@scali.no (Steffen Persvold)
Date: Fri, 6 Jul 2001 16:48:38 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        helgehaf@idb.hist.no (Helge Hafting),
        pvvvarma@techmas.hcltech.com (Vasu Varma P V),
        linux-kernel@vger.kernel.org
In-Reply-To: <3B45D656.440A34A9@scali.no> from "Steffen Persvold" at Jul 06, 2001 05:16:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IXqQ-0004Y9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > GFP_DMA is ISA dma reachable, Forget the IA64, their setup is weird and 
> > > should best be ignored until 2.5 as and when they sort it out.
> 
> Really ? I don't think I can ignore IA64, there are people who ask for it....

Well the current IA64 tree isnt related to the standard Linux behaviour so you
need to take that up with the IA64 people. Obviously their non standard
behaviour causes problems.
> 

