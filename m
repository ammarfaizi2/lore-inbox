Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTJ0RCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263430AbTJ0RCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:02:03 -0500
Received: from hell.org.pl ([212.244.218.42]:55308 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263415AbTJ0RCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:02:01 -0500
Date: Mon, 27 Oct 2003 18:02:03 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, M?ns Rullg?rd <mru@users.sourceforge.net>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031027170203.GA11206@hell.org.pl>
Mail-Followup-To: "Yu, Luming" <luming.yu@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	M?ns Rullg?rd <mru@users.sourceforge.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <3ACA40606221794F80A5670F0AF15F8401720B67@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720B67@pdsmsx403.ccr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Yu, Luming:
> I made a mistake in using base_number. Would you please have updated patch a try?
> Thanks a lot. --Luming

The updated patch fixes the issue, the interrupts now still occur after S1
resume.
Thanks,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
