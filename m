Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263423AbTCNSMv>; Fri, 14 Mar 2003 13:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263424AbTCNSMv>; Fri, 14 Mar 2003 13:12:51 -0500
Received: from [80.190.48.67] ([80.190.48.67]:263 "EHLO mx00.linux-systeme.com")
	by vger.kernel.org with ESMTP id <S263423AbTCNSMu> convert rfc822-to-8bit;
	Fri, 14 Mar 2003 13:12:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.21pre5aa1
Date: Fri, 14 Mar 2003 19:04:57 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030314090825.GB1375@dualathlon.random> <200303141810.54234.m.c.p@wolk-project.de> <20030314173848.GH1375@dualathlon.random>
In-Reply-To: <20030314173848.GH1375@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303141904.57954.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 March 2003 18:38, Andrea Arcangeli wrote:

Hi Andrea,

> the fix for this was supposed to be included in the o1 scheduler patch,
> there is been clearly a merging error, just drop the #ifdef CONFIG_SMP
> around schedule_tail in arch/i386/kernel/entry.S and it'll work fine.
hmm, I wonder where I did the error. You are right. TYVM! Sorry for the noise.

ciao, Marc


