Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSEXRnn>; Fri, 24 May 2002 13:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSEXRnm>; Fri, 24 May 2002 13:43:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62860 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314690AbSEXRni>; Fri, 24 May 2002 13:43:38 -0400
Date: Fri, 24 May 2002 10:43:54 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Austin Gonyou <austin@digitalroadkill.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <433620000.1022262234@flay>
In-Reply-To: <1022261405.9617.39.camel@UberGeek>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume that you mean by "not worth using x86" you're referring to say,
> degraded performance over other platforms? Well...if you talk
> price/performance, using x86 is perfect in those terms since you can buy
> more boxes and have a more fluid architecture, rather than building a
> monolithic system. Monolithic systems aren't always the best. Just look
> at Fermilab!

Well, to be honest, with the current mainline kernel on >4Gb x86 machines,
we're not talking about slow performance on mainline kernel, we're talking
about "falls flat on it's face, in a jibbering heap" (if you actually stress the
machine with real workloads). If we apply a bunch of patches, we can get 
the ostritch to just about fly (most of the time), but we're working towards good 
performance too ... it's not that far off. 

Of course, this means that we actually have to get these patches accepted
for them to be of much use ;-). -aa kernel works best in this area, on the 
workloads I've been looking at so far ... this area is very much "under active
development" at the moment.

M.

