Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274959AbTHLBLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274960AbTHLBLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:11:13 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:58574
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S274959AbTHLBKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:10:24 -0400
Message-ID: <31044.199.181.174.146.1060650619.squirrel@www.blazebox.homeip.net>
In-Reply-To: <3F37F1A4.2030404@genebrew.com>
References: <1060543928.887.19.camel@blaze.homeip.net>	
    <2425882704.1060622541@aslan.btc.adaptec.com>
    <1060623576.2826.9.camel@blaze.homeip.net>
    <3F37F1A4.2030404@genebrew.com>
Date: Mon, 11 Aug 2003 21:10:19 -0400 (EDT)
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
From: "Paul Blazejowski" <paulb@blazebox.homeip.net>
To: "Rahul Karnik" <rahul@genebrew.com>
Cc: "Justin T. Gibbs " <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
User-Agent: SquirrelMail/1.5.0 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Priority: 3
Importance: Normal
Content-Transfer-Encoding: 7BIT
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.7; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Paul Blazejowski wrote:
>
>> Is this due to my mainboard (nforce2),cpu,ACPI,devfs,sysfs...or all
>> these together?
>
> NForce2 + ACPI IRQ routing is a work in progress. Try turning off ACPI
> for the time being and see if it helps.
>
> Thanks,
> Rahul
> --
> Rahul Karnik
> rahul@genebrew.com
>
>
>

Thanks Rahul, i'll try that.Are acpi=off and pci=noacpi the same options?
what about APIC, should i also use noapic option upon booting the kernel
(APIC is compiled in)?

Paul

