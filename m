Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbUCHWfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUCHWfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:35:21 -0500
Received: from gprs40-150.eurotel.cz ([160.218.40.150]:31554 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261361AbUCHWfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:35:12 -0500
Date: Mon, 8 Mar 2004 23:35:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Steve Longerbeam <stevel@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
Message-ID: <20040308223500.GA835@elf.ucw.cz>
References: <40462AA1.7010807@mvista.com> <20040305220950.GA5352@openzaurus.ucw.cz> <404CB3F0.2020701@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404CB3F0.2020701@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>(PRAMFS). It was originally developed for three major consumer
> >>electronics companies for use in their smart cell phones
> >>and other consumer devices.
> >>
> >>An intro to PRAMFS along with a technical specification
> >>is at the SourceForge project web page at
> >>http://pramfs.sourceforge.net/. A patch for 2.6.3 has
> >>been released at the SF project site.
> >
> >Well, I'd certainly love to see some usable linux cell phones. 
> >(Well, one such beast in my pocket would probably be enough :-)
> >(Is there a way to make linux cell phone without second
> >cpu just for GSM stack?)
> >
> 
> one of the chips used in their cell phones is the TI OMAP1510.
> It has an embedded TMS320c55 DSP as well as an ARM 925.

Hmm, but GSM stack needs to be realtime, and it probably will not be
GPL compatible (?). It is just pure curiosity, but I wonder how that
one is being solved...

Well...

Probably GSM stack can be binary-only kernel module?

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
