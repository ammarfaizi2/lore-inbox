Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266737AbUIMNip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266737AbUIMNip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266725AbUIMNip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:38:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60856 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266748AbUIMNh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 09:37:58 -0400
Date: Mon, 13 Sep 2004 15:38:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roel van der Made <roel@telegraafnet.nl>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
Message-ID: <20040913133847.GA9157@elte.hu>
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu> <41456536.6090801@sw.ru> <20040913092443.GA19437@elte.hu> <20040913133437.GW3951@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913133437.GW3951@telegraafnet.nl>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roel van der Made <roel@telegraafnet.nl> wrote:

> > > the last check ensures that we are still hashed and this check is more 
> > > straithforward for understanding, agree?
> > 
> > yep - please send a new patch to Andrew.
> 
> I'll be awaiting the patch and give it a shot.
> 
> Thanks all for the feedback.

you can try my patch too, it will do the job of fixing the bug. The
other changes we talked about are only improvements to the debugging
infrastructure.

	Ingo
