Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSBGMca>; Thu, 7 Feb 2002 07:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287616AbSBGMcS>; Thu, 7 Feb 2002 07:32:18 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30226 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S287591AbSBGMcK>; Thu, 7 Feb 2002 07:32:10 -0500
Date: Thu, 7 Feb 2002 13:31:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Patrick Mochel <mochel@osdl.org>, Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
Message-ID: <20020207123125.GF5247@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020206122253.GB446@elf.ucw.cz> <E16YcaF-0006z9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16YcaF-0006z9-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Case 5: 486 with both PCI and VLB, where ide is on the VLB?
> > 
> > cases 4 and 5 are IMO hard, because it is difficult to know where it
> > really is... and I'm not sure current kernel knows it.
> 
> I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac 
> perfectly ready for a 2.5 merger

PnPBIOS is nasty, and I suspect it is not present/working on all
models, right?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
