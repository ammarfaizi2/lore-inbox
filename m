Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTJYT7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbTJYT7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:59:49 -0400
Received: from gprs198-24.eurotel.cz ([160.218.198.24]:23169 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262851AbTJYT6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:58:34 -0400
Date: Sat, 25 Oct 2003 21:58:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: M?ns Rullg?rd <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031025195817.GB505@elf.ucw.cz>
References: <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se> <20031024222347.GB728@elf.ucw.cz> <yw1xbrs6p85n.fsf@kth.se> <1067039997.2114.16.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067039997.2114.16.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Some modules cause problems. If I suspend with the intel-agp driver
> loaded, for example, the computer reboots when copying the original
> kernel back, because the hardware state doesn't match. I can suspend and
> resume my i830 based laptop just fine without it. Once the right changes
> are made to the driver, the module will work, but not yet.
> 
> Pavel, excuse me for jumping in here.

No problem, I'm actually tired of replying to all those mails myself
;-).

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
