Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267876AbUIFM2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267876AbUIFM2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267880AbUIFM2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:28:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53190 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267876AbUIFM2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:28:37 -0400
Date: Mon, 6 Sep 2004 14:29:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040906122954.GA7720@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <200409061348.41324.rjw@sisk.pl> <1094473527.13114.4.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094473527.13114.4.camel@boxen>
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


* Alexander Nyberg <alexn@dsv.su.se> wrote:

> It doesn't look like it is fully ported to x86_64 systems yet, these
> compile errors are easy to move away but the functionality doesn't
> seem to be there. Probably why Ingo hasn't added the PREEMPT_VOLUNTARY
> to the x86_64 Kconfig even though I saw a few bits of x86_64 code in
> the patch.

yeah, it probably doesnt compile on anything other than x86 right now.

	Ingo
