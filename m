Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVBKSdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVBKSdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVBKSdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:33:07 -0500
Received: from gprs215-110.eurotel.cz ([160.218.215.110]:51938 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261467AbVBKSdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:33:05 -0500
Date: Fri, 11 Feb 2005 19:32:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050211183241.GD2148@elf.ucw.cz>
References: <20050210124636.GA10677@butterfly.hjsoft.com> <20050210183114.GB1577@elf.ucw.cz> <20050211171028.GA20375@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211171028.GA20375@butterfly.hjsoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Try also acpi=off.
> 
> i was hoping for a test that's a bit more granular.  might it be
> possible to disable suspect bits of the acpi code instead of all of it?
> i'm open to applying and testing patches.

Well, you'd have to write that code, I'd guess.

And I do not think you can really turn off thermal managment once you
enter ACPI mode.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
