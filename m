Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSKOWWh>; Fri, 15 Nov 2002 17:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266834AbSKOWWc>; Fri, 15 Nov 2002 17:22:32 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:45780 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S266840AbSKOWVX>;
	Fri, 15 Nov 2002 17:21:23 -0500
Subject: Re: ACPI patches updated (20021111)
From: Stian Jordet <liste@jordet.nu>
To: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115150113.GA18126@resonant.org>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
	 <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net>
	 <20021115150113.GA18126@resonant.org>
Content-Type: text/plain
Organization: 
Message-Id: <1037399340.984.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 15 Nov 2002 23:29:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 2002-11-15 kl. 16:01 skrev Zed Pobre:
> On Wed, Nov 13, 2002 at 01:33:03PM -0800, Stephen Hemminger wrote:
> > Will this fix problems with IRQ routing.
> > On our SMP test machines, ACPI has to be disabled otherwise the SCSI
> > disk controllers don't work.
> 
>     As a further data point, if ACPI is enabled on my non-SMP test
> machine, USB stops working.
Very good to hear I'm not the only one with that problem, though, I have
a smp-machine, but it utterly refuses to work with acpi.

Regards,
Stian Jordet

