Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUHSJoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUHSJoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbUHSJoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:44:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:34471 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264750AbUHSJnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:43:55 -0400
X-Authenticated: #4399952
Date: Thu, 19 Aug 2004 11:54:38 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Thomas Charbonnel <thomas@undata.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P3
Message-Id: <20040819115438.12306093@mango.fruits.de>
In-Reply-To: <20040818122703.GA17301@elte.hu>
References: <1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu>
	<1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu>
	<20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu>
	<20040818141231.4bd5ff9d@mango.fruits.de>
	<20040818122703.GA17301@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 14:27:03 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Hi, it applied against 2.6.8.1 with some offsets and some buzz [?].
> > Well anyways it compiled fine and the copy_page_range latency is
> > gone.. Now i also see the extracty entropy thing, too..
> 
> could you try the attached patch that changes SHA_CODE_SIZE to 3 -
> does this reduce the latency caused by extract_entropy?

sorry, my box got fsck'ed. rebuilding system now. will be a day before i
can resume testing..

flo
