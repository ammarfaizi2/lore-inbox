Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTBXSbg>; Mon, 24 Feb 2003 13:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTBXSaK>; Mon, 24 Feb 2003 13:30:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25615 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267454AbTBXS3n>; Mon, 24 Feb 2003 13:29:43 -0500
Date: Mon, 24 Feb 2003 19:39:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
Message-ID: <20030224183955.GC517@atrey.karlin.mff.cuni.cz>
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224164209.GD13404@poup.poupinou.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have PaceBlade here, and its memory map is wrong, which leads to
> > ACPI refusing to load. [It does not mention "ACPI data" in the memory
> > map at all!]
> 
> I have made those patches to workaround that.  I have no time

Yes, I have seen those... I also made a patch that enables you to do
that workaround from mem= options at kernel command line.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
