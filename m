Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTKPNhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTKPNhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:37:50 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262795AbTKPNht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:37:49 -0500
Date: Sun, 16 Nov 2003 14:38:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Fix firmware loader docs
Message-ID: <20031116133808.GA337@elf.ucw.cz>
References: <20031116131000.GA293@elf.ucw.cz> <1068989412.17638.407.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068989412.17638.407.camel@pegasus>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > AFAICS, sysfs should be mounted on /sys these days...
> 
> we can remove the hotplug-script from 2.4 and 2.6 completly, because the
> firmware.agent script is now part of the linux-hotplug scripts and there
> is no need to write one. You only have to put the firmware file into the
> firmware directory, which is by default /usr/lib/hotplug/firmware/ and
> everything works as expected.

Well, I'd keep them for a while... To stop people wondering "WTF is
this"?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
