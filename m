Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbVCQLcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbVCQLcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbVCQLak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:30:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37087 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263043AbVCQK14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:27:56 -0500
Date: Thu, 17 Mar 2005 11:27:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050317102726.GD4091@elte.hu>
References: <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu> <20050315164420.GT7699@opteron.random> <20050316082851.GB10260@elte.hu> <20050316104618.GB11192@opteron.random> <20050316134150.GA24970@elte.hu> <20050316172850.GF11192@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316172850.GF11192@opteron.random>
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


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> After all those emails I never heard a good argument from you that
> made me even slightly consider changing my plans and to use ptrace
> instead of seccomp, [...]

maybe because i ended up agreeing with you? ;)

	Ingo
