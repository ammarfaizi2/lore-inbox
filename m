Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293330AbSBZVUS>; Tue, 26 Feb 2002 16:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293604AbSBZVUI>; Tue, 26 Feb 2002 16:20:08 -0500
Received: from mailer3.bham.ac.uk ([147.188.128.54]:10457 "EHLO
	mailer3.bham.ac.uk") by vger.kernel.org with ESMTP
	id <S293601AbSBZVUD>; Tue, 26 Feb 2002 16:20:03 -0500
Date: Tue, 26 Feb 2002 21:19:54 +0000 (GMT)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
X-X-Sender: mpc@pc24.sr.bham.ac.uk
To: Vincent Bernat <bernat@free.fr>
cc: Tom Eastep <teastep@shorewall.net>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
In-Reply-To: <m3u1s4asb4.fsf@neo.loria>
Message-ID: <Pine.LNX.4.44.0202262111220.9420-100000@pc24.sr.bham.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Vincent Bernat wrote:

> OoO Pendant le journal télévisé du mardi 26 février 2002, vers 20:57,
> Tom Eastep <teastep@shorewall.net> disait:
> 
> > I'm currently getting around the problem with the following hack:
> 
> You may use the "setpci" command instead to fix this in "userland".

Talking about fixups, did anyone examine the very recent pci bandwidth
patch from VIA and try using setpic for a fixup?  I emailed VIA 
asking for details of the fixup and haven't heard back yet.

(I haven't got windows installed to do a before and after comparison
of the chipset registers to try the fixup here.)

tecchannel.de references: 

PCI Bandwidth:      http://www.tecchannel.de/hardware/817/
VIA Patch Results:  http://www.tecchannel.de/hardware/817/11.html

Peak transfer rates increased from 10-40%

Cheers,

Mark

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
+-------------------------------------------------------------------------+
Mark Cooke                  The views expressed above are mine and are not
Systems Programmer          necessarily representative of university policy
University Of Birmingham    URL: http://www.sr.bham.ac.uk/~mpc/
+-------------------------------------------------------------------------+

