Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTEJTI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTEJTI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:08:29 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:22402
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264476AbTEJTI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:08:26 -0400
Date: Sat, 10 May 2003 15:11:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: David van Hoose <davidvh@cox.net>
cc: Stian Jordet <liste@jordet.nu>, Greg KH <greg@kroah.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: PCI problem [was Re: ACPI conflict with USB]
In-Reply-To: <3EBD49CF.7030304@cox.net>
Message-ID: <Pine.LNX.4.50.0305101511030.11047-100000@montezuma.mastecende.com>
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com>
 <1052444521.3ebb076946267@webmail.jordet.nu> <3EBB0A95.20902@cox.net>
 <3EBD49CF.7030304@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003, David van Hoose wrote:

> If I boot with pci=noacpi, I do *not* have the problem. I still have the 
> timeout, but my trackball works. However, I have many lines of an 
> acpi_irq handler and call trace with the comment 'irq 20: nobody 
> cared!'. I also get 'APIC error on CPU0: 00(40)' and 'APIC error on 
> CPU0: 40(40)' a couple dozen times each.
> 
> If I boot with noacpi *and* pci=noacpi, I have the all of the problems 
> mentioned; no trackball and the pci=noacpi related problems.
> 
> Someone mentioned using noapic, but it doesn't have any effect.
> 
> Any questions?

Is that an AMD/SMP system?

-- 
function.linuxpower.ca
