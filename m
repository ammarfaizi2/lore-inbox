Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTBNUib>; Fri, 14 Feb 2003 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTBNUib>; Fri, 14 Feb 2003 15:38:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267425AbTBNUia>;
	Fri, 14 Feb 2003 15:38:30 -0500
Date: Fri, 14 Feb 2003 00:04:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Daniel Pittman <daniel@rimspace.net>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030213230408.GA121@elf.ucw.cz>
References: <1045106216.1089.16.camel@vmhack> <1045160506.1721.22.camel@vmhack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045160506.1721.22.camel@vmhack>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> temperature (RO)
>   - show: prints temperature in degrees farenheit

Please, use degrees celsius to keep it consistent with ACPI and
lm-sensors.

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
