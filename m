Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270074AbTGMCcK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 22:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270076AbTGMCcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 22:32:10 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:23680 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270074AbTGMCcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 22:32:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 19:39:25 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Jamie Lokier <jamie@shareable.org>,
       Miguel Freitas <miguel@cetuc.puc-rio.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
In-Reply-To: <20030712224246.GA5354@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.55.0307121928540.3528@bigblue.dev.mcafeelabs.com>
References: <1058017391.1197.24.camel@mf> <Pine.LNX.4.55.0307120735540.4351@bigblue.dev.mcafeelabs.com>
 <20030712154942.GB9547@mail.jlokier.co.uk> <Pine.LNX.4.55.0307120845470.4351@bigblue.dev.mcafeelabs.com>
 <20030712224246.GA5354@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Bill Huey wrote:

> Have any of you folks seen this ?
>
> 	http://www.linuxdevices.com/articles/AT6078481804.html
> 	http://research.microsoft.com/~mbj/papers/tr-99-59_abstract.html
>
> Neat stuff. This with a fully preemptive kernel is one of Linux kernel
> dreams for multimedia.

This is funny. Every time I found something interesting to read (papers) I
print them and I stock on my desk. The are 25Kg of papers piled on my desk
right now. Thanks to you, 25.05Kg now ;) Upon a brief read, The Italian Job,
hemm ... paper, is very similar to SOFTRR. Once you change their "server"
notion with the per-user allocation I have in mind, it'll come even
closer. I really didn't have time to read the MS paper though. The problem
is not if it can be done, the problem is how bad ppl wants it.



- Davide

