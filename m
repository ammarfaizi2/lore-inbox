Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUH2BTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUH2BTi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 21:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUH2BTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 21:19:38 -0400
Received: from web13907.mail.yahoo.com ([216.136.175.70]:55568 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267374AbUH2BTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 21:19:37 -0400
Message-ID: <20040829011936.39122.qmail@web13907.mail.yahoo.com>
Date: Sat, 28 Aug 2004 18:19:36 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and others)
To: Lee Revell <rlrevell@joe-job.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1093739136.7078.1.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Lee Revell <rlrevell@joe-job.com> wrote:
> Is this an SMP machine?  There were problems with that version of the
> voluntary preemption patches on SMP.  The latest version, Q3, should fix
> these.
> 
No, it's a single CPU Athlon 1800+, the kernel is compiled in with support for
SMP system, but that should not have any impact.

Nicolas

