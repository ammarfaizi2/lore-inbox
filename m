Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVBOTuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVBOTuD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBOTtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:49:24 -0500
Received: from gprs214-212.eurotel.cz ([160.218.214.212]:18117 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261845AbVBOTrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:47:49 -0500
Date: Tue, 15 Feb 2005 20:47:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Norbert Preining <preining@logic.at>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050215194710.GE7338@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - Sometimes I have to make a Sysrq-s (sync) to get some stuff running
>   (eg logging in from the console hangs after input of passwd, calling
>   sysrq-s makes it continue). I had a similar effect when logging in
>   AFTER resuming (for the resume I had only gdm running but wasn't
>   logged in) the GNOME starting screen stayed there indefinitely, no
>   change. Even after restarting the X server and retrying.
>   Logging in with twm session DID work without any problem.
>   Do you have any idea what this could be?

Does it happen with swsusp? Is it in any way reproducible? Maybe
commenting out refrigerator would help....

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
