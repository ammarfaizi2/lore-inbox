Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUHVHtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUHVHtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 03:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUHVHtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 03:49:53 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43186 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266512AbUHVHtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 03:49:52 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040821140501.GA4189@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu>  <20040821140501.GA4189@elte.hu>
Content-Type: text/plain
Message-Id: <1093160993.817.46.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 Aug 2004 03:49:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 10:05, Ingo Molnar wrote:
> i've uploaded the -P7 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P7

Here's a pretty bad one, over 500 usecs in rt_garbage_collect:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P7#/var/www/2.6.8.1-P7/trace7.txt

Lee

