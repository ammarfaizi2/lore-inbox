Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264871AbSJaMHd>; Thu, 31 Oct 2002 07:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265217AbSJaMHd>; Thu, 31 Oct 2002 07:07:33 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2308 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264871AbSJaMHc>;
	Thu, 31 Oct 2002 07:07:32 -0500
Date: Thu, 31 Oct 2002 00:09:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <20021031000908.A517@elf.ucw.cz>
References: <20021030171149.GA15007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030171149.GA15007@suse.de>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Latest version of this document can always be found at
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
> 
> 
> Regressions:
> ~~~~~~~~~~~~
> (Things not expected to work just yet)
> - The hptraid/promise RAID drivers are currently non functional.
> - Various SCSI drivers still need work, and don't even compile.
> - software suspend is still in development, and in need of more work.
>   It is unlikely to work as expected currently.

As swsusp is new feature in 2.5. (it does not exist in official 2.4),
I do not think it is regression. Anyway, I hope to fix that real soon
now.
								Pavel
-- 
When do you have heart between your knees?
