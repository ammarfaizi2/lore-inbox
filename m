Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUGJICA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUGJICA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUGJICA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:02:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1165 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266183AbUGJIB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:01:59 -0400
Date: Sat, 10 Jul 2004 10:02:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Redeeman <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710080234.GA25155@elte.hu>
References: <20040709182638.GA11310@elte.hu> <1089407610.10745.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089407610.10745.5.camel@localhost>
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


* Redeeman <lkml@metanurb.dk> wrote:

> this all seems pretty cool... do you think you could make a patch
> against mm for this? it would be greatly apreciated

it should apply cleanly to 2.6.7-mm6. -mm7 already includes most of the
might_sleep() additions. I'll do a patch against -mm7 too.

	Ingo
