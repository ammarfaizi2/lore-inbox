Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSACWVW>; Thu, 3 Jan 2002 17:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288343AbSACWVO>; Thu, 3 Jan 2002 17:21:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288342AbSACWU5>; Thu, 3 Jan 2002 17:20:57 -0500
Subject: Re: ISA slot detection on PCI systems?
To: mochel@osdl.org (Patrick Mochel)
Date: Thu, 3 Jan 2002 22:31:30 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mail_ker@xarch.tu-graz.ac.at (Alex),
        vonbrand@inf.utfsm.cl (Horst von Brand), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.33.0201031419400.826-100000@segfault.osdlab.org> from "Patrick Mochel" at Jan 03, 2002 02:20:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGOY-0001Hj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PnPBIOS also enumerates the legacy hardware that can be known about (ie
> > is soldered down)
> 
> How do you derive that information? Some table, right? (Sorry, I haven't
> RTFS yet).

You make BIOS32 calls
