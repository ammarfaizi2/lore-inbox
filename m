Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267862AbUHNBRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267862AbUHNBRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 21:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUHNBRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 21:17:15 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37561 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267862AbUHNBRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 21:17:14 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813104817.GI8135@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe>  <20040813104817.GI8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092446273.803.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 21:17:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:48, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:

>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7
> 

Some more interesting results.  I am not seeing much of a difference in
performance, but the shape of the distribution changes quite a bit:

http://krustophenia.net/testresults.php?dataset=2.6.8-rc3-O5
http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7

Lee

