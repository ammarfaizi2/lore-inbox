Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284335AbRLXC2u>; Sun, 23 Dec 2001 21:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284356AbRLXC2k>; Sun, 23 Dec 2001 21:28:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63505 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284335AbRLXC2Z>; Sun, 23 Dec 2001 21:28:25 -0500
Subject: Re: Booting a modular kernel through a multiple streams file
To: mm@ns.caldera.de (Marcus Meissner)
Date: Mon, 24 Dec 2001 02:38:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200112232305.fBNN5vM19844@ns.caldera.de> from "Marcus Meissner" at Dec 24, 2001 12:05:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IL0o-0002Ua-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Apart that it moves the initrd somewhere unsafe on high memory machines
> and some other odds ends we have fixed, I know of exactly 1 problem with a
> hw raid controller, which we did not come around to debug yet.
> 
> All other machines, obscure as they may are, boot just fine and without  
> problems with GRUB.

I can introduce you to machines that don't work with grub in my
test collection. Things like the keyboard not working with a USB
keyboard on one box.

Alan
