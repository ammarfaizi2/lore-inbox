Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTKTW1u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTKTW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:27:50 -0500
Received: from gprs147-68.eurotel.cz ([160.218.147.68]:13696 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262882AbTKTW1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:27:49 -0500
Date: Thu, 20 Nov 2003 23:28:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>, hannal@us.ibm.com
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: driver model for inputs
Message-ID: <20031120222825.GE196@elf.ucw.cz>
References: <20031119213237.GA16828@fs.tum.de> <20031119221456.GB22090@kroah.com> <1069283566.5032.21.camel@nosferatu.lan> <20031119232651.GA22676@kroah.com> <20031120125228.GC432@openzaurus.ucw.cz> <20031120170303.GJ26720@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120170303.GJ26720@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Greg said:

> I have patches for the memory devices, all sound drivers (ALSA and OSS),
> frame buffer devices, and misc devices in my linuxusb.bkbits.net/usb-2.5
> tree.  Hanna Linder is working on the input sysfs patches, and has
> posted some work in the past.

I could only find 2.5.70 patches, and those did not seem "good enough"
to do power managment with them. Do you have some newer version?

[One of machines near me needs keyboard to be reinitialized after S3
sleep... And users are starting to hit that, too.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
