Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288353AbSACW1M>; Thu, 3 Jan 2002 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288352AbSACW1D>; Thu, 3 Jan 2002 17:27:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36618 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288349AbSACW0p>; Thu, 3 Jan 2002 17:26:45 -0500
Subject: Re: ISA slot detection on PCI systems?
To: Lionel.Bouton@free.fr (Lionel Bouton)
Date: Thu, 3 Jan 2002 22:36:39 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), balbir.singh@wipro.com (BALBIR SINGH),
        esr@thyrsus.com, dwmw2@infradead.org (David Woodhouse),
        davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <3C34D0D9.6010008@free.fr> from "Lionel Bouton" at Jan 03, 2002 10:44:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MGTX-0001J5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I think we should try is to identify the most stable interfaces 
> (lspci works ok for most systems and would be of great help), use them 
> and let the user fill the gap (ISA/MCA/VLB/AGP bus switches for the 
> *user* is a great idea indeed).

Most of the PC stuff is doable. If you doubt that run a Red Hat 7.2 install
and simply keep hitting the default options 8) 
