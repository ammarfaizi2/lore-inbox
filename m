Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265720AbTIFCDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 22:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbTIFCDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 22:03:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:64947 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265720AbTIFCDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 22:03:45 -0400
Date: Fri, 5 Sep 2003 19:03:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, Chris Wright <chrisw@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI fixed)
Message-ID: <20030905190338.W16228@osdlab.pdx.osdl.net>
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060016.16545.adq_dvb@lidskialf.net> <20030905170224.A16217@osdlab.pdx.osdl.net> <200309060221.30741.adq_dvb@lidskialf.net> <3F592AA7.7020700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F592AA7.7020700@pobox.com>; from jgarzik@pobox.com on Fri, Sep 05, 2003 at 08:30:31PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Andrew de Quincey wrote:
> > successful dmesg
> > dmesg from a failed boot
> > /proc/acpi/dsdt
> > /proc/interrupts
> 
> dmidecode output is also quite helpful.

I've uploaded these to:

http://lsm.immunix.org/~chris/acpi/

You'll find dmesg and interrupts from pci=noacpi, acpi=off, disassembled
dsdt and dmidecode.  Don't have the failed boot dmesg yet.  I ported
netconsole to my eth driver, but it's not yet working.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
