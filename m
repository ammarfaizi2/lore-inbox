Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288333AbSACWQn>; Thu, 3 Jan 2002 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288336AbSACWQg>; Thu, 3 Jan 2002 17:16:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288333AbSACWQR>; Thu, 3 Jan 2002 17:16:17 -0500
Subject: Re: ISA slot detection on PCI systems?
To: mochel@osdl.org (Patrick Mochel)
Date: Thu, 3 Jan 2002 22:26:39 +0000 (GMT)
Cc: mail_ker@xarch.tu-graz.ac.at (Alex),
        vonbrand@inf.utfsm.cl (Horst von Brand), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.33.0201031017190.837-100000@segfault.osdlab.org> from "Patrick Mochel" at Jan 03, 2002 10:22:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGJr-0001Gp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't believe that Win2k does it (it's not from the PnP family, is it?).
> But, I don't doubt that XP does it on contemporary hardware. It requires
> ACPI support in the BIOS. And, ACPI enumerates all of the legacy devices
> in the system.

PnPBIOS also enumerates the legacy hardware that can be known about (ie
is soldered down)

Alan
