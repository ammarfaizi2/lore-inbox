Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTEIMvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEIMvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:51:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26251
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263169AbTEIMvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:51:45 -0400
Subject: Re: 2.4.21-rc boot stalls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052471062.2087.57.camel@localhost.localdomain>
References: <1052371307.2703.43.camel@localhost.localdomain>
	 <1052392048.10038.9.camel@dhcp22.swansea.linux.org.uk>
	 <1052471062.2087.57.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052481955.14538.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 13:05:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-09 at 10:04, Bob Gill wrote:
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_ACPI is not set
> 
> My motherboard has the SiS645 chipset.  
> The SiS961 is the I/O APIC (ACPI 1.0b and APM 1.2 Compliant).

SiS APIC's are only supported in 2.5.x

