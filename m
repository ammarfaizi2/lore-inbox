Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264696AbSJOQVo>; Tue, 15 Oct 2002 12:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSJOQVo>; Tue, 15 Oct 2002 12:21:44 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:51913 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264696AbSJOQVn>; Tue, 15 Oct 2002 12:21:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <baldrick@wanadoo.fr>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Use of yield() in the kernel
Date: Tue, 15 Oct 2002 18:27:45 +0200
User-Agent: KMail/1.4.3
References: <200210151820.24429.m.c.p@wolk-project.de>
In-Reply-To: <200210151820.24429.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210151827.45149.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This already bit ext3 transaction batching, c.f. Andrew Morton's
> >
> >> [PATCH] remove the sched_yield from the ext3 fsync path
>
> where did you read this ^^? :)
>
> ciao, Marc

http://linux.bkbits.net:8080/linux-2.5/cset@1.733.7.6?nav=index.html|ChangeSet@-7d

Duncan.
