Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRDJLFc>; Tue, 10 Apr 2001 07:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRDJLFP>; Tue, 10 Apr 2001 07:05:15 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:50956
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S131382AbRDJLEz>; Tue, 10 Apr 2001 07:04:55 -0400
Date: Tue, 10 Apr 2001 07:13:34 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.11 of the aic7xxx driver availalbe
Message-ID: <20010410071334.A706@animx.eu.org>
In-Reply-To: <200104100234.f3A2YFs23361@aslan.scsiguy.com> <E14mvvQ-0003zl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E14mvvQ-0003zl-00@the-village.bc.nu>; from Alan Cox on Tue, Apr 10, 2001 at 12:03:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >So, what about on an alpha system.  I've asked a few times what I could do,
> > >but you didn't help nor explain what you meant.
> > 
> > From talking to the maintainer of the QLogic driver, it appears
> > that there is a generic issue with data mapping on the Alpha.
> > The only way to correct this issue will be for someone to debug
> > it.
> 
> This seems to be the case for some Alpha boxes. On these aic7xxx dies with
> 2.4 but then so does IDE DMA for example. The real test would be to run
> Justin's 2.2.19 patch driver and see if that works on Alpha.

Sure, I'll try it.  I didn't have any luck with the one from 2.2.17 or
2.2.18 on this system.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
