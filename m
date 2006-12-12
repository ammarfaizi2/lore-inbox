Return-Path: <linux-kernel-owner+w=401wt.eu-S932244AbWLLRU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWLLRU5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWLLRU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:20:57 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57174 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbWLLRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:20:55 -0500
Message-ID: <457EE4F3.6000001@garzik.org>
Date: Tue, 12 Dec 2006 12:20:51 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, Josh Boyer <jwboyer@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
References: <457EA2FE.3050206@garzik.org> <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com> <457EA86B.5010407@garzik.org> <20061212170125.GA19592@nostromo.devel.redhat.com>
In-Reply-To: <20061212170125.GA19592@nostromo.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham wrote:
> Jeff Garzik (jeff@garzik.org) said: 
>> It's always been the case that we remove Linux kernel code when the 
>> number of users (and more importantly, developers) drops to near-nil.
> 
> So, drivers/net/3c501.c?

Depends on how motivated Alan remains ;-)  Historically, if the 
developer is active, we have occasionally ignored the miniscule userbase.

	Jeff



