Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVLAXLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVLAXLX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVLAXLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:11:23 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:42836 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932550AbVLAXLW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:11:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IuztwpzFf+Z9Locn7CPPRQSTpNraEsd0lgUCtHQvzogd4a5kfE9mqj7nuEZdvXaTEYt47l3nMGPx7AuVTm7lcpTwER6jL8Tj8XQ3uEJnomqoO0kMDk7P3aEVn9ryUC2vstUbl1Wq1yJ11bTPN13szuJHrqUQtmoenrGr6Xa/C0w=
Message-ID: <6bffcb0e0512011511i164c50efg@mail.gmail.com>
Date: Fri, 2 Dec 2005 00:11:21 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.5 for 2.6.14, 2.6.15-rc2 and 2.6.15-rc2-mm1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <438F7F2E.3080300@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <438648F5.2010706@bigpond.net.au> <438E8C8C.7030304@bigpond.net.au>
	 <438F7F2E.3080300@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/12/05, Peter Williams <pwil3058@bigpond.net.au> wrote:
[snip]
> This patch will also successfully apply to 2.6.15-rc4.

here are my benchmarks:
http://stud.wsi.edu.pl/~piotrowskim/research/linux/plugsched/
(spa_ws, spa_svr and zaphod will be soon).

(athlon 2400 xp, 512 mb ram, 2.6.15-rc3-mm1)

I have some problems with interbench on that machine, ib stops on
ubuntu:/usr/src/tmp/interbench-0.29# ./interbench
loops_per_ms unknown; benchmarking...
.

All kernbench resoults should be +/- 02/12/2005 01:30 UTC.

Regards,
Michal Piotrowski
