Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVBMNDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVBMNDj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVBMNDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:03:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43428 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261269AbVBMNC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:02:57 -0500
Date: Sun, 13 Feb 2005 14:02:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
Message-ID: <20050213130247.GA10681@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108274835.3739.2.camel@krustophenia.net>
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

> Are there any known incompatibilities with oprofile and the RT preempt
> patch?

not that i know of. Does the same thing work fine with !PREEMPT_RT? (or
the patch unapplied?)

	Ingo
