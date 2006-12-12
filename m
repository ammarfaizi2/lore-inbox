Return-Path: <linux-kernel-owner+w=401wt.eu-S932251AbWLLRCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWLLRCz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWLLRCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:02:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236AbWLLRCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:02:53 -0500
Date: Tue, 12 Dec 2006 12:01:25 -0500
From: Bill Nottingham <notting@redhat.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Josh Boyer <jwboyer@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061212170125.GA19592@nostromo.devel.redhat.com>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Josh Boyer <jwboyer@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
References: <457EA2FE.3050206@garzik.org> <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com> <457EA86B.5010407@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457EA86B.5010407@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik (jeff@garzik.org) said: 
> It's always been the case that we remove Linux kernel code when the 
> number of users (and more importantly, developers) drops to near-nil.

So, drivers/net/3c501.c?

Bill
