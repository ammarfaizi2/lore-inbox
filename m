Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVBMNRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVBMNRC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVBMNRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:17:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47490 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261273AbVBMNQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:16:54 -0500
Date: Sun, 13 Feb 2005 14:16:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050213131634.GA13162@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net> <1108300516.7818.68.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108300516.7818.68.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> PS. Ingo: Any plans to move the RT tree to -mm again (would save me
> time patching; does keep me practised though)?

not at the moment - but you might want to make your port available to
others?

	Ingo
