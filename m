Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTK1QKf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTK1QKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:10:35 -0500
Received: from gprs148-17.eurotel.cz ([160.218.148.17]:22656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262566AbTK1QK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:10:29 -0500
Date: Fri, 28 Nov 2003 17:10:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Damien Sandras <dsandras@seconix.com>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] If your ACPI-enabled machine does clean shutdown randomly...
Message-ID: <20031128161030.GC303@elf.ucw.cz>
References: <20031128145249.GA563@elf.ucw.cz> <1070035371.1055.13.camel@golgoth01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070035371.1055.13.camel@golgoth01>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...then you probably need this one. (One notebook I have here
> > certainly needs it).
> > 
> > It seems that acpi likes to report completely bogus value from time to
> > time...
> > 
> 
> The problem with that patch is that it is filling the logs, but it is
> certainly better than shutting the machine down without warning. I had
> that problem and it took me a few minutes to figure out that it was
> ACPI.

I'm not pushing this patch for inclusion, only its second part.

> However, I didn't have that problem with kernel 2.6.0 test 9, it
> appeared with 2.6.0 test 10 and test 11. I have mailed the list to see
> if there was no patch I could reverse to determine where the problem
> was, but I got no reaction, so I guess I will have to live with it ;)

I have this on rather strange hw, so my tests do not count :-(.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
