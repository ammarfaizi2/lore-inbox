Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVBMNPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVBMNPW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVBMNPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:15:22 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:38474 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261268AbVBMNPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:15:18 -0500
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1108274835.3739.2.camel@krustophenia.net>
References: <1108274835.3739.2.camel@krustophenia.net>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 14:15:16 +0100
Message-Id: <1108300516.7818.68.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 01:07 -0500, Lee Revell wrote:
> Are there any known incompatibilities with oprofile and the RT preempt patch?

non so far for me, I use that combo quite a lot at work. However I do
use the -mm series which might contain oprofile updates not found in
plain -rc.

Kind regards,

PeterZ

PS. Ingo: Any plans to move the RT tree to -mm again (would save me time
patching; does keep me practised though)?

