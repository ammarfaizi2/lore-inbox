Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268449AbUHLHZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268449AbUHLHZC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUHLHZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:25:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58047 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268447AbUHLHW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:22:26 -0400
Date: Thu, 12 Aug 2004 09:21:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
Message-ID: <20040812072127.GA20386@elte.hu>
References: <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe> <20040811073149.GA4312@elte.hu> <20040811074256.GA5298@elte.hu> <1092210765.1650.3.camel@mindpipe> <20040811090639.GA8354@elte.hu> <20040811141649.447f112f@mango.fruits.de> <20040811124342.GA17017@elte.hu> <1092268536.1090.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092268536.1090.7.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> There is definitely some subtle bug in the preempt-timing patch,
> because I am getting reports of long non-preemptible sections, which
> do not correspond to an xrun in jackd - if these were real then even a
> 400usec non-preemptible section would cause an xrun.  I do not seem to
> get many xruns during normal jackd operation.

could you send me these latest preempt-timing warnings?

	Ingo
