Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTFHSCs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTFHSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 14:02:48 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:18090 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263638AbTFHSCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 14:02:47 -0400
Date: Sun, 8 Jun 2003 20:16:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Support for mach-xbox
Message-ID: <20030608181610.GA9182@elf.ucw.cz>
References: <20030602202714.GD18786@h55p111.delphi.afb.lu.se> <20030606145651.GB4960@zaurus.ucw.cz> <20030608091806.GB1702@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608091806.GB1702@h55p111.delphi.afb.lu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Attached is a patch that adds a new subachitecture for the xbox gaming
> > 
> > Why does xbox need new subarchitecture?
> > It should be normal PC...
> 
> It need to blacklist some pci-devices, if you touch them it hangs. And it
> has different CLOCK_TICK_RATE. So booting an xbox-kernel on other
> PC's will

Okay, different CLOCK_TICK_RATE is good enough reason I guess.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
