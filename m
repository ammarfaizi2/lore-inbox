Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbTIFMcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTIFMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 08:32:41 -0400
Received: from lidskialf.net ([62.3.233.115]:41933 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262076AbTIFMck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 08:32:40 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Date: Sat, 6 Sep 2003 13:32:39 +0100
User-Agent: KMail/1.5.3
Cc: Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <200309051958.02818.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com> <20030905190338.W16228@osdlab.pdx.osdl.net>
In-Reply-To: <20030905190338.W16228@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309061332.39489.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 September 2003 03:03, Chris Wright wrote:
> * Jeff Garzik (jgarzik@pobox.com) wrote:
> > Andrew de Quincey wrote:
> > > successful dmesg
> > > dmesg from a failed boot
> > > /proc/acpi/dsdt
> > > /proc/interrupts
> >
> > dmidecode output is also quite helpful.
>
> I've uploaded these to:
>
> http://lsm.immunix.org/~chris/acpi/
>
> You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
> dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
> netconsole to my eth driver, but it's not yet working.

Cool, ta.. I'll have a look, but I'll probably need the failed dmesg to make 
any real progress.

