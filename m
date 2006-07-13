Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWGMEDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWGMEDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWGMEDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:03:38 -0400
Received: from c-67-160-253-166.hsd1.ca.comcast.net ([67.160.253.166]:10928
	"EHLO pronyma.talinet.net") by vger.kernel.org with ESMTP
	id S932183AbWGMEDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:03:37 -0400
DomainKey-Signature: a=rsa-sha1; h=Received:Date:To:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent:From; b=lz0xblud6L4qm7X1iEurV3nRIB75ek5pOYtw9F56VvOtf7XyfQ9GdC+yUYF0nCrKrFbmT9uv6f++I9YB6Wmv9nezNcqGubeao0wyJAz0FV+4s+hFsWuL1dmpVNGJyc1K; c=nofws; d=talinet.net; q=dns; s=selector1
Date: Wed, 12 Jul 2006 21:03:34 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.6.17 transparent bridge report
Message-ID: <20060713040334.GA27078@mail.talinet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: talisein@talinet.net (talisein)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

dmesg asked that I enable pci=assign-busses and report the results here.
Hardware is Alienware 7700 laptop, will happilly respond with more info
if needed.
Applicable (?) data below:

ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 2.10 entry at 0xfd951, last bus=10
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEG_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10) *11
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 11) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 11) *10
ACPI: Embedded Controller [EC] (gpe 29) interrupt mode.


-- 
Andrew Potter
talisein@talinet.net
