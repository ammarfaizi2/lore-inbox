Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSJCXHg>; Thu, 3 Oct 2002 19:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSJCXHg>; Thu, 3 Oct 2002 19:07:36 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:61863 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261339AbSJCXHf>; Thu, 3 Oct 2002 19:07:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Pfaller <apfaller@yahoo.com.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: linux-2.4.20-pre8-ac3: NFS performance regression
Date: Fri, 4 Oct 2002 01:15:48 +0200
User-Agent: KMail/1.4.3
References: <200210032024.47664.apfaller@yahoo.com.au> <1033683184.28814.35.camel@irongate.swansea.linux.org.uk> <shsu1k316jn.fsf@charged.uio.no>
In-Reply-To: <shsu1k316jn.fsf@charged.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210040115.13878.apfaller@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 00:50, Trond Myklebust wrote:
> >>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>      > On Thu, 2002-10-03 at 19:32, Andreas Pfaller wrote:
>      >
>     >> However I noticed a significant NFS performance drop with
>     >> 2.4.20-pre8-ac3. Other network throughput is not affected.
>     >>
>      > I see this with all recent 2.4.20pre and 2.4.20pre-ac
>      > kernels. I've not had time to retest with Trond's fixes to
>      > recheck it all
>
> FYI, here is the 'fix' Alan is talking about. It could be worth
> trying...

That 'fix' is already included in 2.4.20-pre8-ac3.

Cheers,
Andreas

