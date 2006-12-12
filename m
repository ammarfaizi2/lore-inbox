Return-Path: <linux-kernel-owner+w=401wt.eu-S932260AbWLLRVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWLLRVc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWLLRVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:21:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52290 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932255AbWLLRVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:21:30 -0500
Date: Tue, 12 Dec 2006 17:28:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Bill Nottingham <notting@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Josh Boyer <jwboyer@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061212172843.40edbaed@localhost.localdomain>
In-Reply-To: <20061212170125.GA19592@nostromo.devel.redhat.com>
References: <457EA2FE.3050206@garzik.org>
	<625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
	<457EA86B.5010407@garzik.org>
	<20061212170125.GA19592@nostromo.devel.redhat.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 12:01:25 -0500
Bill Nottingham <notting@redhat.com> wrote:

> Jeff Garzik (jeff@garzik.org) said: 
> > It's always been the case that we remove Linux kernel code when the 
> > number of users (and more importantly, developers) drops to near-nil.
> 
> So, drivers/net/3c501.c?

I think 3c501.c is a case where putting in an "If you use this email ..
or it will go away" might be a good idea indeed.
