Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUHNLoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUHNLoG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUHNLoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:44:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10190 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266476AbUHNLnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:43:52 -0400
Date: Sat, 14 Aug 2004 13:45:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O8
Message-ID: <20040814114506.GA9705@elte.hu>
References: <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040814075135.GB20123@mars.ravnborg.org> <1092476112.803.72.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092476112.803.72.camel@krustophenia.net>
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

> > > other changes in -O8: the massive kallsyms-lookup speedup from Paulo
> > > Marque
> > 
> > Do you have this as an independent patch - or an URL?
> > 
> 
> http://lkml.org/lkml/2004/8/14/3

this has the (gcc's bogus) compiler warning - i sent the fixed up
version to Sam separately.

	Ingo
