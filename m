Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbTFWWMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbTFWWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:12:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60902 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265420AbTFWWJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:09:06 -0400
Date: Mon, 23 Jun 2003 23:23:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Message-ID: <20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
References: <20030623221541.GA8096@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623221541.GA8096@alf.amelek.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 12:15:41AM +0200, Marek Michalkiewicz wrote:
> long time ago I noticed a problem with the ACPI IRQ not working
> if it is _not_ shared with some other PCI IRQ.  The problem still
> exists in the 2.4.21 kernel, confirmed on two machines with the
> MSI MS-6368L motherboard (VIA PLE133 chipset).

Have you patched 2.4.21 with the latest ACPI patch, or is this vanilla
2.4.21?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
