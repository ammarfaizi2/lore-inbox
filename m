Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVGEN6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVGEN6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGEN6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:58:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24741 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261858AbVGENvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:51:46 -0400
Date: Tue, 5 Jul 2005 15:51:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: rt-preempt build failure
Message-ID: <20050705135143.GA13614@elte.hu>
References: <200507052308.43970.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507052308.43970.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Hi Ingo
> 
> This config on i386:
> http://ck.kolivas.org/crap/rt-config
> 
> realtime-preempt-2.6.12-final-V0.7.50-51
> fails to build with these errors:

thanks, i have fixed this and have uploaded the -51-00 patch.

	Ingo
