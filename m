Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVCaCkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVCaCkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVCaCkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:40:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:41689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262494AbVCaCkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:40:17 -0500
Date: Wed, 30 Mar 2005 18:39:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: trond.myklebust@fys.uio.no, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-Id: <20050330183957.2468dc21.akpm@osdl.org>
In-Reply-To: <1112236017.26732.4.camel@mindpipe>
References: <1112137487.5386.33.camel@mindpipe>
	<1112138283.11346.2.camel@lade.trondhjem.org>
	<1112192778.17365.2.camel@mindpipe>
	<1112194256.10634.35.camel@lade.trondhjem.org>
	<20050330115640.0bc38d01.akpm@osdl.org>
	<1112217299.10771.3.camel@lade.trondhjem.org>
	<1112236017.26732.4.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> > Yes. Together with the radix tree-based sorting of dirty requests,
>  > that's pretty much what I've spent most of today doing. Lee, could you
>  > see how the attached combined patch changes your latency numbers?
>  > 
> 
>  Different code path, and the latency is worse.  See the attached ~7ms
>  trace.

Is a bunch of gobbledygook.  Hows about you interpret it for us?
