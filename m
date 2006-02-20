Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWBTSwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWBTSwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBTSwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:52:33 -0500
Received: from secure.htb.at ([195.69.104.11]:54802 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S932386AbWBTSwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:52:32 -0500
Date: Mon, 20 Feb 2006 19:52:21 +0100
From: Richard Mittendorfer <delist@gmx.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: ACPI \_sb_
Message-Id: <20060220195221.1d294109.delist@gmx.net>
In-Reply-To: <1140459102.2979.72.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.61.0602201850120.24598@yvahk01.tjqt.qr>
	<1140459102.2979.72.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1FBG91-00013W-00*73ulbwxWZ8s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Arjan van de Ven <arjan@infradead.org> (Mon, 20 Feb 2006
19:11:42 +0100):
> On Mon, 2006-02-20 at 18:50 +0100, Jan Engelhardt wrote:
> > Hi,
> > 
> > 
> > does anyone know what the SB in \_SB_.PCI0._PRT means?
> > 
> 
> southbridge?

...
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
...

systembus?

sl ritch
