Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136763AbREIRNX>; Wed, 9 May 2001 13:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136761AbREIRNO>; Wed, 9 May 2001 13:13:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21259 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136758AbREIRNC>; Wed, 9 May 2001 13:13:02 -0400
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
To: dledford@redhat.com (Doug Ledford)
Date: Wed, 9 May 2001 18:16:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bennyb@ntplx.net (Benedict Bridgwater),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3AF9799E.FA8C0D61@redhat.com> from "Doug Ledford" at May 09, 2001 01:08:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xXa5-0002om-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only way a motherboard BIOS would know if the PCI BIOS used polling
> methods instead of interrupt methods is if it was a built in device.  For all

Such as the motherboard IDE ?

> for all bootable devices on the system, regardless of PnPOS settings.  Name
> one concrete example of a motherboard BIOS that doesn't and I'll recant.

I agree it is unlikely, but then so is a wrong $PIRQ table..
