Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTIJOiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264788AbTIJOiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:38:54 -0400
Received: from gprs147-217.eurotel.cz ([160.218.147.217]:36481 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263961AbTIJOiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:38:50 -0400
Date: Wed, 10 Sep 2003 16:38:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Claas Langbehn <claas@rootdir.de>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030910143837.GC2589@elf.ucw.cz>
References: <20030910103142.GA1053@rootdir.de> <20030910111312.GA847@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910111312.GA847@rootdir.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I also tried to suspend with ACPI in single user mode:
> 
> echo 3 >/proc/acpi/sleep
> 
> makes the system sleep within a second.
> 
> After waking it up by pressing a key or the power button
> the VGA Bios shows up for a second and afterwards I get
> this message:
> 
> APIC error on CPU0: 08(08)
> 
> ...and it repeats endlessly :(
> 
> my keyboard is dead afterwards.

Can you test on -test3 kernel?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
