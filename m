Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130988AbRBAQeU>; Thu, 1 Feb 2001 11:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRBAQeK>; Thu, 1 Feb 2001 11:34:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130988AbRBAQeB>; Thu, 1 Feb 2001 11:34:01 -0500
Subject: Re: 2.4.1 DAC960 driver bug or what's going on?
To: silviu@delrom.ro (Silviu Marin-Caea)
Date: Thu, 1 Feb 2001 16:35:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010201181233.21076d38.silviu@delrom.ro> from "Silviu Marin-Caea" at Feb 01, 2001 06:12:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OMhR-0004ZR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 1 Feb 2001 15:31:44 +0000 (GMT)
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Which compiler out of curiosity
> Works with kgcc.  Thank you Alan.
> 
> I thought RedHat fixed their compiler.

Im not yet sure if its the compiler or the DAC960 driver which is at fault
here. I'm looking at some 'interesting' reports about bitfield behaviour
which is why I suspected this

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
