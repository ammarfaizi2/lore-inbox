Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSA2SYx>; Tue, 29 Jan 2002 13:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289796AbSA2SYn>; Tue, 29 Jan 2002 13:24:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36614 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289795AbSA2SYb>; Tue, 29 Jan 2002 13:24:31 -0500
Subject: Re: nm256 patch for Latitude LS
To: hcp@met.ed.ac.uk (H C Pumphrey)
Date: Tue, 29 Jan 2002 18:36:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10201231005500.11847-100000@humilis> from "H C Pumphrey" at Jan 23, 2002 10:22:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vd7h-0004mX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With the patch, the hardware seems to work OK. I don't know whether the
> "fix" causes a "break" on any other nm256 hardware. I have tested the
> patch on kernels 2.2.19 and 2.2.20 -- once I upgrade to Debian testing
> I'll try out a 2.4 kernel. I'm posting this now in the hope that this
> information might be of use to at least one other nm256 user out there.
> It's a darn sight better than the pcsp patch!

I've thrown it into my working test set for the next -ac - we'll see if
it breaks any other chips pretty soon. The diff applies as is to 2.4.

Thanks

Alan
