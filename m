Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbTCBVIC>; Sun, 2 Mar 2003 16:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTCBVIC>; Sun, 2 Mar 2003 16:08:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45326 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265097AbTCBVIB>; Sun, 2 Mar 2003 16:08:01 -0500
Date: Sun, 2 Mar 2003 21:18:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, John Weber <weber@sixbit.org>
Subject: Re: [UPDATED PATCH] pcmcia: add bus_type pcmcia_bus_type, struct pcmcia_driver
Message-ID: <20030302211820.C10914@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@brodo.de>,
	linux-kernel@vger.kernel.org, John Weber <weber@sixbit.org>
References: <20030301213328.GA4480@brodo.de> <3E625D76.8050503@sixbit.org> <20030302210622.GA20572@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030302210622.GA20572@brodo.de>; from linux@brodo.de on Sun, Mar 02, 2003 at 10:06:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 10:06:22PM +0100, Dominik Brodowski wrote:
> That's great. However, this depends on Linus merging my patch. And it may
> well be (and I even suggest this) that he takes Russell King's pcmcia/cardbus 
> patches first.

I doubt my patches will be affecting anything in the area of this
patch.

I'm going to try to get the stuff which doesn't touch the PCI related
code merged asap so the overall patch size is back down to something
managable.  Currently, it's extremely hairy trying to sort stuff out
into reasonably sized chunks...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

