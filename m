Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266649AbUBDWVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266651AbUBDWVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:21:32 -0500
Received: from gprs148-146.eurotel.cz ([160.218.148.146]:53120 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266649AbUBDWV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:21:28 -0500
Date: Wed, 4 Feb 2004 23:21:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Huw Rogers <count0@localnet.com>, linux-kernel@vger.kernel.org,
       ncunningham@users.sourceforge.net, linux-laptop@mobilix.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Message-ID: <20040204222113.GA425@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401CBB670@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401CBB670@PDSMSX403.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > [Do *not* enable suspend on SMP for mainline, unless you are willing
> > to audit that code...]
> 
> When do you want to have SMP support ? This is a laptop having HT.

Well, when _my_ laptop has HT, I guess :-)))))).

[Or when patrick/nigel gets to it, or when cpu hotplug is merged;
whichever comes sooner].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
