Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUHPDCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUHPDCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUHPDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:02:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20709 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267373AbUHPDCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:02:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816025846.GA10240@elte.hu>
References: <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu>
	 <20040816025846.GA10240@elte.hu>
Content-Type: text/plain
Message-Id: <1092625400.867.126.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:03:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 22:58, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> i've attached mlock-test2.cc that should test this theory. The code
> breaks up the mlock-ed region into 8 equal pieces and does mlock() on
> them separately. It's basically a lock-break done in user-space. Does
> this change the nature of xruns?

-ENOATTACHMENT

Lee

