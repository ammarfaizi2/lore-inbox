Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbULMHNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbULMHNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 02:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbULMHNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 02:13:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:42124 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262264AbULMHN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 02:13:26 -0500
Date: Mon, 13 Dec 2004 08:09:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041213070944.GA3345@elte.hu>
References: <1102776772.2968.4.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102776772.2968.4.camel@rousalka.dyndns.org>
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


* Nicolas Mailhot <Nicolas.Mailhot@laPoste.net> wrote:

> Just FYI real-time kernels do not boot on my Fedora Devel (Rawhide)
> system, including -RT-2.6.10-rc2-mm3-V0.7.32-12. 2.6.10-rc2-mm4 OTOH
> boots fine. It freezes just after initial hardware init before going
> into gfx mode.
> 
> (kernel config available on demand, it's almost the same - 2.6.10-rc2-
> mm4 was generated using a make oldconfig on the -RT-2.6.10-rc2-mm3-
> V0.7.32-12 file)

cannot reproduce this on two testsystems using your .config, so it's
probably some hardware detail that makes the difference.

	Ingo
