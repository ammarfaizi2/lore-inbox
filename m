Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVAGQot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVAGQot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVAGQom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:44:42 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:4996 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261514AbVAGQlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:41:40 -0500
Date: Fri, 7 Jan 2005 17:41:37 +0100
From: Martin Mares <mj@ucw.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107164137.GA7672@ucw.cz>
References: <20050107160808.GB6529@ucw.cz> <200501071614.j07GEgEC018705@localhost.localdomain> <20050107162902.GA7097@ucw.cz> <s5h7jmpw5zh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7jmpw5zh.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Yes, but is there really some difference between people having to enable
> > LSM and add a new LSM module, and people recompiling the kernel to include
> > capabilities?
> 
> For distributors, it's much easier to provide an additional module
> than to let people recompile kernels.

Well, if LSM is enabled in the kernel, enabling capabilities should be
a single insmod, shouldn't it?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The better the better, the better the bet.
