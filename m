Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTICSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTICSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:14:36 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:42764 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S264179AbTICSMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:12:37 -0400
Date: Wed, 3 Sep 2003 15:13:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew de Quincey <adq_dvb@lidskialf.net>, Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] Where do I send APIC victims?
In-Reply-To: <1062589205.19059.6.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309031511420.6102-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Sep 2003, Alan Cox wrote:

> On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > 2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch for 
> > nforce2 boards) so it will start having the same issue with the BIOS bug in 
> > KT333/KT400  boards.
> 
> It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> basically unusable on anything I own thats not intel. 

I've collected a few 2.4.22 ACPI problems and sent them to the ACPI guys.

Randy, Len? Any update on any bug? 

