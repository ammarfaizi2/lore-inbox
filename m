Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTE0Prt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTE0Prt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:47:49 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:10421 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263867AbTE0Prr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:47:47 -0400
Subject: Re: ALSA problems: sound lockup, modules, 2.5.70
From: Stian Jordet <liste@jordet.nu>
To: Florin Iucha <florin@iucha.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527130539.GG3359@iucha.net>
References: <200305270311.10530.ivg2@cornell.edu>
	 <20030527130539.GG3359@iucha.net>
Content-Type: text/plain
Message-Id: <1054051326.611.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 27 May 2003 18:02:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 27.05.2003 kl. 15.05 skrev Florin Iucha:
> Alsa worked fine for me in 2.5.68-bk18. It started hanging on halt
> in -bk19 and .70. I haven't played anything to see if it hangs on
> access.

I can confirm this behaviour. Kinda weird, I think it is rather
unrelated to sound itself, because there haven't been any changes in
that area. Hmm. Annoying. Except for this, I have absolutely no issues
with 2.5.70, everything works perfect. I love it :)

Best regards,
Stian

