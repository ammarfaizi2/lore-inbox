Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbWBACRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbWBACRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWBACRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:17:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964877AbWBACRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:17:10 -0500
Date: Tue, 31 Jan 2006 18:16:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
In-Reply-To: <20060201020437.GA20719@kroah.com>
Message-ID: <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
References: <20060201020437.GA20719@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Greg KH wrote:
> 
> linas:
>       PCI Hotplug: PCI panic on dlpar add (add pci slot to running partition)
>       PCI Hotplug/powerpc: module build break
> 
> linas@austin.ibm.com:
>       powerpc/PCI hotplug: remove rpaphp_find_bus()
>       powerpc/PCI hotplug: merge config_pci_adapter

Looks like Linas Vepstas doesn't have a good email address in his From: 
fields.. As a result, the logs are nasty. 

Linas - could you _please_ fix your email setup, of if your email setup is 
good, could whoever added the bogus "From: " line to the email please NOT 
DO THAT HORRIBLE THING?

Greg, if you notice things like this, can you fix them up or bounce them 
back to the author? Yeah, I let mistakes get through too, so I shouldn't 
throw stones, but it's just so much _nicer_ if things look nice in the 
logs etc, so I try to catch it when I can..

		Linus
