Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUC0AVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 19:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUC0AVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 19:21:09 -0500
Received: from fmr99.intel.com ([192.55.52.32]:56547 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S261505AbUC0AVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 19:21:07 -0500
Subject: AE_NOT_ACQUIRED, ACPI: Unable to start the ACPI Interpreter
From: Len Brown <len.brown@intel.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>, 15444@t-link.de,
       gigerstyle@gmx.ch, trond.myklebust@fys.uio.no
Cc: Marcel Holtmann <marcel@holtmann.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Rik van Ballegooijen <sleightofmind@xs4all.nl>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1080278805.755.157.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6523@hdsmsx402.hd.intel.com>
	 <1080278805.755.157.camel@dhcppc4>
Content-Type: text/plain
Organization: 
Message-Id: <1080346823.16211.21.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2004 19:20:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 00:26, Len Brown wrote:
> > > ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 22 low level)
> > 
> > > ACPI: SCI (IRQ22) allocation failed
> > >  ACPI-0133: *** Error: Unable to install System Control Interrupt
> > Handler, AE_NOT_ACQUIRED
> > > ACPI: Unable to start the ACPI Interpreter

If you encounter this issue on your hardware, can you help me fix it by
testing the latest patch at the URL below?  Either attach your dmesg and
/proc/interrupts to the bug report or send it to me, and let me know if
your power button works?

thanks,
-Len

> > http://bugzilla.kernel.org/show_bug.cgi?id=2366


