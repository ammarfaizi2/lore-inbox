Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268431AbTCFVzw>; Thu, 6 Mar 2003 16:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbTCFVzw>; Thu, 6 Mar 2003 16:55:52 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1028 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268431AbTCFVzv>;
	Thu, 6 Mar 2003 16:55:51 -0500
Date: Thu, 6 Mar 2003 22:41:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: daveman@bellatlantic.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing keypress when ACPI enabled
Message-ID: <20030306214113.GA181@elf.ucw.cz>
References: <20030306164840.GA2078@bellatlantic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306164840.GA2078@bellatlantic.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since about 2.5.60, the first 2.5 kernel that has built/booted for
> me, I've noticed X/Kscreensaver fails to capture a keystroke after
> about 20 minutes of inactivity, in the password login prompt. It is
> only the first keypress that is lost, all later keypresses work
> fine. I believe I've narrowed it down to an interaction with having
> ACPI enabled, as booting the kernel with 'acpi=off' seems to make
> the problem go away. I've attached dmesg and .config output. Please
> let me know if I can assist further.

Be happy (and keep your lines < 70 columns): HP omnibook locks up
randomly when you type on keyboard, and pressing power button is
needed to unlock it.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
