Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTIRLfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 07:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbTIRLfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 07:35:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62953 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261161AbTIRLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 07:35:12 -0400
Date: Wed, 17 Sep 2003 16:11:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Vaio doesn't poweroff with 2.4.22
Message-ID: <20030917141110.GA9125@openzaurus.ucw.cz>
References: <20030917103135.GL1205@elf.ucw.cz> <Pine.GSO.4.21.0309171445150.3677-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309171445150.3677-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > And was that acpi or apm? If it was acpi you saw a little miracle.
> 
> ACPI.
> 
> BTW, I just started to see other weird things that may be related to ACPI, but
> aren't related to Linux (machine powers down 1 second after power up, etc.),
> but now it's fine again (running 2.4.21).

I have seen similar crazy stuff (like hard crash with power LED going
both green *and* red on OS boot (any OS, even w98) after poweron.
Only cure was to unplug it and remove battery. Seeing crash
where 4-sec-power no longer worked was pretty common...

ACPI tends to provoke rather weird hw problems.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

