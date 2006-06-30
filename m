Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWF3Hzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWF3Hzk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWF3Hzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:55:40 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:46045 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751408AbWF3Hzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:55:39 -0400
Message-ID: <1151654134.44a4d8f6dc320@imp5-g19.free.fr>
Date: Fri, 30 Jun 2006 09:55:34 +0200
From: castet.matthieu@free.fr
To: albertl@mail.com, Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Unicorn Chang <uchang@tw.ibm.com>, Doug Maxey <dwm@maxeymade.com>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org> <449E5445.60008@free.fr> <44A4CE21.30009@tw.ibm.com>
In-Reply-To: <44A4CE21.30009@tw.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 62.160.59.193
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Selon Albert Lee <albertcc@tw.ibm.com>:

>
> Could you please test the current libata-upstream tree and
> turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in include/linux/libata.h.
>
Is there a easy way to get libata-upstream tree ?
Do I need to install git for that or there are some snapshots somewhere ?


> If possible, could you also submit the libata log related to the
> early/lost irq.
Where are this infos ?

IRRC, libata counts lost irq, but display only a message each 1000 losts irq.

Matthieu
