Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVBMNUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVBMNUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVBMNUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 08:20:19 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.20]:33047 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261274AbVBMNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 08:20:14 -0500
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050213131634.GA13162@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net>
	 <1108300516.7818.68.camel@twins>  <20050213131634.GA13162@elte.hu>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 14:20:12 +0100
Message-Id: <1108300812.7818.70.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 14:16 +0100, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > PS. Ingo: Any plans to move the RT tree to -mm again (would save me
> > time patching; does keep me practised though)?
> 
> not at the moment - but you might want to make your port available to
> others?

Sure, I'll post the diff next time I do one.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

