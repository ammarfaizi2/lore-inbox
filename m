Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVJJPZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVJJPZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 11:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVJJPZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 11:25:47 -0400
Received: from mx1.netapp.com ([216.240.18.38]:36792 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1750852AbVJJPZr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 11:25:47 -0400
X-IronPort-AV: i="3.97,194,1125903600"; 
   d="scan'208"; a="261011776:sNHT20485304"
Subject: Re: Problem with nfs4, kernel 2.6.13.2
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43498432.8060503@gmx.de>
References: <200509251516.23862.MalteSch@gmx.de>
	 <1127737730.8453.5.camel@lade.trondhjem.org>
	 <200509262218.15885.MalteSch@gmx.de>  <43498432.8060503@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Organization: Network Appliance, Inc
Date: Mon, 10 Oct 2005 11:25:45 -0400
Message-Id: <1128957945.8451.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-OriginalArrivalTime: 10 Oct 2005 15:25:46.0100 (UTC) FILETIME=[E2AE3B40:01C5CDAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

su den 09.10.2005 Klokka 22:57 (+0200) skreiv Malte Schröder:
> >>>
> >>>You may also want to retest with
> >>>
> >>>http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1/linux-2.6.13-001-NFS_ALL_MODIFIED.dif
> >>>

> The above server is currently unreachable from my part of the net but
> Bret Towe seemed to have the same problem as I have. Since the problem
> also appears when using 2.6.14-rc3 I think the patch should be looked at
> and maybe considered for inclusion. As soon as I gain access to that
> patch I will test it and report my results.

I wrote all the elements in that patch so believe me, it has been
considered. 8-)

...however I still need to clean a few things up a bit before I'm ready
to send it on to Andrew and Linus. Do not expect it to appear in 2.6.14,
but rather in 2.6.15 (and possibly the 2.6.14-mm).

Cheers,
  Trond
