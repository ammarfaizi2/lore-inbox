Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSKYSFs>; Mon, 25 Nov 2002 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSKYSFr>; Mon, 25 Nov 2002 13:05:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14858 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262779AbSKYSFq>; Mon, 25 Nov 2002 13:05:46 -0500
Date: Mon, 25 Nov 2002 19:12:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       Ducrot Bruno <poup@poupinou.org>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021125181259.GB5302@atrey.karlin.mff.cuni.cz>
References: <20021125121545.GA22915@suse.de> <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org> <20021119164550.GQ11952@fs.tum.de> <20021123195720.GA310@elf.ucw.cz> <4020.1038240431@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4020.1038240431@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  Nice. Shame about all those boxes that won't boot without ACPI. 
> 
> I've heard a lot about such beasts but have never actually _met_ one. 
> 
> If I accidentally bought a box which wouldn't boot without ACPI, it would 
> go immediately back from whence it came -- just as it would if it turned up 
> with an nVidia graphics card.

I have omnibook xe3, will boot without ACPI but USB will not work due
to interrupt routing problems. It has buggy PIR$ table, acpi tables
are okay. Of course it is HP bug.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
