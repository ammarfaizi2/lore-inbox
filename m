Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTLDK4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 05:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTLDK4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 05:56:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261217AbTLDK4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 05:56:22 -0500
Date: Thu, 4 Dec 2003 11:56:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Damien Sandras <damien.sandras@it-optics.com>
Cc: "Yu, Luming" <luming.yu@intel.com>, Aaron Lehmann <aaronl@vitelus.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: Tell user when ACPI is killing machine
Message-ID: <20031204105621.GE11044@atrey.karlin.mff.cuni.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720BFD@pdsmsx403.ccr.corp.intel.com> <20031204095454.GC6911@atrey.karlin.mff.cuni.cz> <1070532076.1645.42.camel@golgoth01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070532076.1645.42.camel@golgoth01>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a similar problem since test10 and test11 (2.4.23 is ok, test9 is
> ok too). ACPI reports bogus temperatures and powers the machine
> down.

> If you have a patch that could fix that problem, I'm ready to try it and
> report success or failure ;)

I have ugly workaround ("if temperature reported is > 200Celsius,
ignore it").
								Pavel

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
