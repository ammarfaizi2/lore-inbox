Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWH1Vzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWH1Vzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWH1Vzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:55:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28319 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964791AbWH1Vzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:55:52 -0400
Date: Mon, 28 Aug 2006 23:55:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Sreenivas.Bagalkote@lsil.com, Sumant.Patro@lsil.com, jeff@garzik.org,
       axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_sas suspend ok, resume oops
Message-ID: <20060828215540.GA1335@elf.ucw.cz>
References: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0608281004g30706834r96d5d24f85e82cc9@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Anyone working on suspend/resume for the Megaraid SAS RAID card?
> 
> This is on a DELL 2950.
> 
> Suspend/resume (to disk) has been running great on my IBM x60s, but
> when I tried the same kernel (2.6.18-rc4) on the DELL 2950, it
> suspended ok, but when resuming, the megaraid driver crashed.

Debug megaraid driver, then ;-). Really, without any details, no, I
do not think we can help.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
