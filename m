Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278675AbRJZP5v>; Fri, 26 Oct 2001 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278727AbRJZP51>; Fri, 26 Oct 2001 11:57:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14091 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278675AbRJZP5W>; Fri, 26 Oct 2001 11:57:22 -0400
Subject: Re: PCI IRQ (routing) problem with mediaGX
To: ww@kt.e-technik.uni-dortmund.de (Wolfgang Wegner)
Date: Fri, 26 Oct 2001 17:04:27 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011026170143.B15834@bigmac.e-technik.uni-dortmund.de> from "Wolfgang Wegner" at Oct 26, 2001 05:01:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15x9T9-0000VU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Attached are lspci -v output and the boot.msg of the non-working kernel
> 2.4.9-ac12 (sorry, latest I tried...)

Does 2.4.9 linus work - it might be the cyrix bits I'd forgotten about 
from the -ac stuff that probably want shooting
