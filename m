Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280479AbRKNLKI>; Wed, 14 Nov 2001 06:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280474AbRKNLJu>; Wed, 14 Nov 2001 06:09:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280460AbRKNLJ3>; Wed, 14 Nov 2001 06:09:29 -0500
Subject: Re: 2.4.14 fails to boot on a MediaGX
To: matlhdam@iinet.net.au (Adam Harvey)
Date: Wed, 14 Nov 2001 11:17:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <01111412325302.00696@blackbox.local> from "Adam Harvey" at Nov 14, 2001 12:32:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163y2Z-0004OH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Working around Cyrix MediaGX virtual DMA bugs.
> > > CPU: Cyrix MediaGX 3x Core/Bus Clock
> > > Checking 'hlt' instruction... OK.
> >
> > 2.4.12-ac was working on my 233Mhz MediaGX. I suspect 2.4.14 does too. I'll
> > give it a test tho
> 
> Thanks for the help.

Ok on my box it boots fine. As an experiment can you build a kerne with no
PCI support (Im not saying it'll be useful production wise but it will tell
me if its a PCI issue)
