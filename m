Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUHSLXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUHSLXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUHSLXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:23:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4999 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265383AbUHSLWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:22:17 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P4
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Charbonnel <thomas@undata.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040819132837.2c5403f4@mango.fruits.de>
References: <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu>  <20040819132837.2c5403f4@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1092914613.830.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 07:23:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 07:28, Florian Schmidt wrote:
> On Thu, 19 Aug 2004 09:32:47 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > i've uploaded the -P4 patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P4
> 
> Hi, this patch doesn't really apply cleanly. Do i need to worry about
> the "fuzz" and the offsets?
> 

Does not seem to hurt anything.  Ingo probably has some differences in
his tree, the 'fuzz' just means that patch was smart enough to figure
out that they don't matter.

Lee

