Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUAVAc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 19:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUAVAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 19:32:29 -0500
Received: from gprs148-45.eurotel.cz ([160.218.148.45]:16768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266148AbUAVAc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 19:32:27 -0500
Date: Thu, 22 Jan 2004 01:32:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "tuija t." <tuxakka@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swusp acpi
Message-ID: <20040122003212.GC300@elf.ucw.cz>
References: <200401211143.51585.tuxakka@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401211143.51585.tuxakka@yahoo.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And with pressing power button everything else comes back exept
> usb.
> This behaviour is kind of "little light nap" and system comes back fast.
> And I have also noticed that I cannot use bios passwd with
> # echo 3 > /proc/acpi/sleep   cause even it doesn't reboot it goes
> somehow to bios and bios passwd prompted but it doesn't accept it?
> But after disabled bios passwd it works exept usb.
> 
> Can somebody give me any wise what I'm doing wrong or point
> me to some documentation about this matter?

Seems like USB suspend/resume support is not yet working... Talk to
usb maintainers and offer them some testing...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
