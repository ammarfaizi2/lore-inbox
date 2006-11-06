Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753022AbWKFM7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022AbWKFM7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbWKFM7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:59:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35561 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1753021AbWKFM7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:59:39 -0500
Date: Mon, 6 Nov 2006 13:58:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061106125818.GA20351@elf.ucw.cz>
References: <20061103163012.GA84707@cave.trolltruffles.com> <20061105204741.GA1847@elf.ucw.cz> <20061106101329.GA16817@2ka.mipt.ru> <20061106101633.GE2978@elf.ucw.cz> <20061106103724.GA4535@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106103724.GA4535@2ka.mipt.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you explain why kevent is better than kqueue?
> 
> According to my tests kevent is noticebly faster.
> It is already too big flag that old system should not be used.
> And half of my previous mail to you shows why kevent is better/different
> from kqueue.

You shown why it is _different_. How much faster is "noticebly
faster"?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
