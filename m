Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUGMBB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUGMBB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGMBBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:01:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:3292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264444AbUGMBBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:01:48 -0400
Date: Mon, 12 Jul 2004 18:00:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Depner <eviltwin69@cableone.net>
Cc: linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712180029.3ae079be.akpm@osdl.org>
In-Reply-To: <1089680288.29230.5.camel@eviltwin>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<1089680288.29230.5.camel@eviltwin>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please don't top-post)

Jan Depner <eviltwin69@cableone.net> wrote:
>
> Is this problem strictly with reiserfs in 2.6 or is it also a problem
> with 2.4.  I actually experienced fewer xruns with reiserfs vs ext3 on
> 2.4 (preempt/ll) but I have no hard numbers to back that up.

Actually, the 2.4 low-latency patch does still have some reiserfs fixes, so
it's probably better than reiserfs in 2.6.

