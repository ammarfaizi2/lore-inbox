Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTH3LL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 07:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTH3LL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 07:11:56 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:15519 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262235AbTH3LLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 07:11:43 -0400
Date: Sat, 30 Aug 2003 13:11:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test4][ACPI] STR, STD returns immidiately
Message-ID: <20030830111124.GC386@elf.ucw.cz>
References: <200308241537.54494.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308241537.54494.fedor@karpelevitch.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> when I do 
> echo mem > /sys/power/state
> or
> echo disk > /sys/power/state
> 
> it returns in a second without any effect and in sysslog I get this:

Patrick broke whole powermanagment in -test4. It is not worth even
trying.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
