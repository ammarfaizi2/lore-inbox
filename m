Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267990AbUHKIZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267990AbUHKIZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267991AbUHKIZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 04:25:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36820 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267990AbUHKIZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 04:25:44 -0400
Date: Wed, 11 Aug 2004 10:27:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040811082712.GB6528@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092210765.1650.3.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another thing: do you see the 10 msec latency every time you run
mlockall-test, or does it only happen sporadically?

	Ingo
