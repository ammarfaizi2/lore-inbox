Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVHQXze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVHQXze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVHQXzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:55:33 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:26052 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751339AbVHQXzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:55:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Date: Thu, 18 Aug 2005 09:45:50 +1000
User-Agent: KMail/1.8.2
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <43001E18.8020707@bigpond.net.au> <200508180916.08454.kernel@kolivas.org> <4303CCB9.6000403@bigpond.net.au>
In-Reply-To: <4303CCB9.6000403@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508180945.50185.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 09:48 am, Peter Williams wrote:
> Con Kolivas wrote:
> > On Thu, 18 Aug 2005 09:15 am, Peter Williams wrote:
> >>Con Kolivas wrote:
> > He did a make allyesconfig which is a bit different and probably far too
> > i/o bound. By the way a single kernel compile is hardly a reproducible
> > benchmark. Ideally he should be using my 'kernbench' benchmark (hint
> > hint).
>
> Is that what I meant when I said "contest"?  I wasn't sure that I used
> the right name.

No, they're different things. Kernbench is a script to do the kernbench 
measurement as used by M. Bligh. It's one of my family of benchmarks ;)

http://contest.kolivas.org
http://kernbench.kolivas.org
http://interbench.kolivas.org

Cheers,
Con
