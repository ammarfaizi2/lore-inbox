Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVBONRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVBONRf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVBONRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:17:35 -0500
Received: from hell.org.pl ([62.233.239.4]:57094 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261714AbVBONR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:17:29 -0500
Date: Tue, 15 Feb 2005 14:17:30 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Norbert Preining <preining@logic.at>
Cc: Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050215131730.GA22194@hell.org.pl>
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	Pavel Machek <pavel@suse.cz>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
	rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Norbert Preining:
> vga=normal plus boot-radeon (webpage(5)) works to get text console
> back. But switching to X freezes the computer completely.
> 
> X from debian sid. 
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-10 20041215174925 fabbione@fabbione.net)
> Release Date: 15 August 2003

Get a recent X version, 4.4, 6.7.0 or 6.8.2 will do. Alternatively, disable
DRI.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
