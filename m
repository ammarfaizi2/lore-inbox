Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281856AbRLHP1C>; Sat, 8 Dec 2001 10:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRLHP0n>; Sat, 8 Dec 2001 10:26:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54022 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281852AbRLHP0f>; Sat, 8 Dec 2001 10:26:35 -0500
Subject: Re: Memory Interleave + kernel + VIA chipsets == possible ?
To: pproios@hotmail.com (Pantelis Proios)
Date: Sat, 8 Dec 2001 15:35:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F760JPzw2O8Z9B5un770001e64e@hotmail.com> from "Pantelis Proios" at Dec 08, 2001 05:02:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CjVw-0001lU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to enable the memory interleaving of modern VIA chipsets 
> (Apollo Pro-133 in my case) through the Linux kernel or some other software?

If your hardware supports it the BIOS should have done so.

> >From what I understand it's done through some PCI register tweaking ..
> Can it be done with setpci or code is needed ?

setpci should be sufficient.
