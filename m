Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289795AbSAKAOx>; Thu, 10 Jan 2002 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289800AbSAKAOn>; Thu, 10 Jan 2002 19:14:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27663 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289795AbSAKAO2>; Thu, 10 Jan 2002 19:14:28 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: Ronald.Wahl@informatik.tu-chemnitz.de (Ronald Wahl)
Date: Fri, 11 Jan 2002 00:26:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <m2wuypn3zs.fsf@goliath.csn.tu-chemnitz.de> from "Ronald Wahl" at Jan 11, 2002 01:08:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OpWJ-00061v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hard to get emulations right. I grant that this wasn't helped by the fact
> > the gcc x86 folks also couldnt read the pentium pro manual correctly.
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^       
> What do you mean with this? Explain, please!

gcc told to generate i686 binaries uses cmov unconditionally. The intel
PPro handbook explicitly says that cmov must be checked for.

> myself but I have also some older machines here that have a k6 or a
> pentium. For mistake I installed the wrong rpm and had a non working
> system. An emulation for such cases would be a _real_ feature at least

So you have a buggy rpm program. Get the rpm program fixed so it correctly
stops you from doing that.

Alan
--
	    If my call is so important to you why don't you hire 
		  some more people to answer the telephone? 
