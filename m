Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbRHBOvK>; Thu, 2 Aug 2001 10:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268966AbRHBOvA>; Thu, 2 Aug 2001 10:51:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7442 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268951AbRHBOut>; Thu, 2 Aug 2001 10:50:49 -0400
Subject: Re: booting SMP P6 kernel on P4 hangs.
To: indigoid@higherplane.net (john slee)
Date: Thu, 2 Aug 2001 15:50:05 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        macro@ds2.pg.gda.pl (Maciej W. Rozycki),
        arjanv@redhat.com (Arjan van de Ven), linux-kernel@vger.kernel.org
In-Reply-To: <20010803000043.F1183@higherplane.net> from "john slee" at Aug 03, 2001 12:00:43 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJnZ-0000lB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Aug 02, 2001 at 01:30:53PM +0100, Alan Cox wrote:
> > I think just disable SMP in that case. There are currently no SMP Pentium IV
> > boxes and perhaps Intel will have fixed it by the time SMP Pentium IV exists
> 
> yes there are, they may not be available to the general public yet
> however:
> 
> http://anandtech.com/cpu/showdoc.html?i=1472&p=5

Which gives intel plenty of time to fix their bios problems. Right now the
situation is we are seeing Pentium IV boxes reporting invalid MP 1.4 specs
and dying. Reporting an invalid MP spec and booting single user at least 
ensures people can boot their boxes while intel fixes their problems

