Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbRHJLVJ>; Fri, 10 Aug 2001 07:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHJLVA>; Fri, 10 Aug 2001 07:21:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267009AbRHJLUr>; Fri, 10 Aug 2001 07:20:47 -0400
Subject: Re: PDC20268 chipset support for kernel 2.4.7
To: krause@pissedoff.com
Date: Fri, 10 Aug 2001 12:23:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010810130500.A1327@chrsch.chem.tu-berlin.de> from "Martin Krause" at Aug 10, 2001 01:05:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VANb-0000oE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch provides support for the Promise Ultra100Tx2 controller card
> (PDC20268 chipset) and works for kernel version 2.4.7.
> But apparently there is still a problem with the 20268. The driver reports
> an error message: "Mode MASTER Error"

The 20268 is not the same as the other promise drivers. The driver for it is 
in the 2.4.7-ac branch of the kernel tree but not yet Linus tree.

Alan
