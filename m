Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLASaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 13:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTLASaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 13:30:21 -0500
Received: from gprs144-162.eurotel.cz ([160.218.144.162]:2688 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263850AbTLASaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 13:30:18 -0500
Date: Mon, 1 Dec 2003 19:30:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Craig Bradney <cbradney@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031201183046.GB255@elf.ucw.cz>
References: <200311292325.44935.csawtell@paradise.net.nz> <1070104685.29442.24.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070104685.29442.24.camel@athlonxp.bradney.info>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
> I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
> turned on (SMP off, Preemptible Kernel off).
> 
> Although the PC hasnt been under constant stress, uptime is over 12
> hours and its not the first time its been up for 12 or more with test 11
> (which was my first 2.6 kernel). Running Gentoo Linux btw.

Try noapic.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
