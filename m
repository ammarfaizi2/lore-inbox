Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUGZVJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUGZVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUGZVIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:08:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64438 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266003AbUGZU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:58:36 -0400
Date: Mon, 26 Jul 2004 22:59:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040726205933.GA27567@elte.hu>
References: <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu> <20040726204228.GA1231@ss1000.ms.mff.cuni.cz> <20040726205741.GA27527@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726205741.GA27527@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> does the patch below, ontop of -J7, help?

i've added this patch to -J7, so re-downloading the -J7 patch should
give you the patch too.

	Ingo
