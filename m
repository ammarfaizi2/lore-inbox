Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSL3QZP>; Mon, 30 Dec 2002 11:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSL3QZP>; Mon, 30 Dec 2002 11:25:15 -0500
Received: from mail.ithnet.com ([217.64.64.8]:16915 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266996AbSL3QZP>;
	Mon, 30 Dec 2002 11:25:15 -0500
Date: Mon, 30 Dec 2002 17:33:33 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC with SIS
Message-Id: <20021230173333.5f28edb9.skraw@ithnet.com>
In-Reply-To: <1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
References: <20021230170822.1b79ebb3.skraw@ithnet.com>
	<1041267723.13956.24.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Dec 2002 17:02:03 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mon, 2002-12-30 at 16:08, Stephan von Krawczynski wrote:
> > Hello,
> > 
> > can any kind soul tell me the chances for implementation of:
> > 
> > <6>PCI: Using IRQ router SIS [1039/0008] at 00:01.0
> > <6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
> > 
> > in 2.4 ?
> > This message shows up if enabling APIC on boards with SIS630 chipset.
> 
> You need some kernel patches, updated ACPI and ACPI enabled to use the
> SIS APIC in this setup

Where to find?
Thanks for your quick answer.

-- 
Regards,
Stephan

