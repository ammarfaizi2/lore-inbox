Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUA0Kh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 05:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUA0Kh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 05:37:59 -0500
Received: from mail.broadpark.no ([217.13.4.2]:8111 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263388AbUA0Kht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 05:37:49 -0500
Message-ID: <002201c3e4c1$9b7df490$1e00000a@black>
Reply-To: "Daniel Andersen" <daniel@majorstua.net>
From: "Daniel Andersen" <kernel-list@majorstua.net>
To: "John Heil" <kerndev@sc-software.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401262211480.7728@scsoftware.sc-software.com>
Subject: Re: Is gcc 3.2.2 suitable for kernel builds?
Date: Tue, 27 Jan 2004 11:37:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems that some gcc 3.2.2 optimizations are generating
> bogus code sequences.
>
> Has anyone else had compiler issues w gcc 3.2.2?
>
> Thanks much,
>
> johnh

As recently posted in a thread "gcc 2.95.3", please have a look at
http://developer.osdl.org/cherry/compile/

3.2.2 and 2.6.x should work fine under most circumstances.

What kernel-version, optimizations and architecture are you using?

Daniel Andersen

