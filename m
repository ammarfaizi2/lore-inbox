Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVBEMgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVBEMgF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVBEMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:36:05 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:8372 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S265682AbVBEM3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:29:54 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4204B3C1.80706@rainbow-software.org>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
	 <1107569842.8575.44.camel@tyrosine>
	 <9e47339105020418306a4c2c93@mail.gmail.com>
	 <1107591336.8575.51.camel@tyrosine>  <4204B3C1.80706@rainbow-software.org>
Date: Sat, 05 Feb 2005 12:28:53 +0000
Message-Id: <1107606533.8575.57.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-02-05 at 12:53 +0100, Ondrej Zary wrote:

> I wonder how this can work:
> a motherboard with i815 chipset (integrated VGA), Video BIOS is 
> integrated into system BIOS
> a PCI card inserted into one of the PCI slots, configured as primary in 
> system BIOS

The issue seems to be specific to laptops. Regardless, it's likely that
Windows knows how to initialise the card without needing to use the
BIOS.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

