Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272603AbTHEJNK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272604AbTHEJNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:13:10 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:40601 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272603AbTHEJNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:13:08 -0400
Date: Tue, 5 Aug 2003 11:12:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Split SOFTWARE_SUSPEND and ACPI_SLEEP
Message-ID: <20030805091245.GA278@elf.ucw.cz>
References: <20030726223958.GA473@elf.ucw.cz> <Pine.LNX.4.44.0308041752180.23977-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308041752180.23977-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Splits two config options to avoid user confusion. Patrick already has
> > better version of that patch in his tree, and probably wants to avoid
> > applying this.
> 
> Correct, I opted for my version, which moves kernel/suspend.c to 
> kernel/power/swsusp.c, and moves the refrigerator code to process.c in 
> that directory.

I actually like your version more. Good.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
