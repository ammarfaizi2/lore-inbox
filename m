Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKKoy>; Thu, 11 Jan 2001 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRAKKoo>; Thu, 11 Jan 2001 05:44:44 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:18724 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129406AbRAKKoe>; Thu, 11 Jan 2001 05:44:34 -0500
Date: Thu, 11 Jan 2001 12:51:36 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Nguyen Truong Sinh <n.t.sinh@vnnews.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Message from new kernel
In-Reply-To: <012101c07b96$a4d04f80$0e6419ac@db.vnnews.com>
Message-ID: <Pine.LNX.4.21.0101111250450.15742-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001, Nguyen Truong Sinh wrote:

> I am using Redhat 7.0 for my system. After install new kernel (2.4.0). My system always inform 
> NET: 3 messages suppressed
> 
> What does it mean ? and how to fix it, I don't want it appears on the console at all.

man syslog

messages supressed means it didn't write all three messages, but a line
saying that the three messages where the same as the previous one in the
logs.

> 
> Thanks.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
