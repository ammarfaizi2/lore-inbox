Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268711AbUHUAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268711AbUHUAnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268748AbUHUAnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:43:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63667 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268711AbUHUAns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:43:48 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040820195540.GA31798@elte.hu>
References: <20040816034618.GA13063@elte.hu>
	 <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <20040820133031.GA13105@elte.hu>  <20040820195540.GA31798@elte.hu>
Content-Type: text/plain
Message-Id: <1093049026.838.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 20:43:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-20 at 15:55, Ingo Molnar wrote:
> i've uploaded the -P6 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P6
> 

Traces here (I have given up on giving them descriptive names).  Max is
about 120 usec:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P6

Lee


