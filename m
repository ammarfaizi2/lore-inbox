Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUDFN3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUDFN3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:29:53 -0400
Received: from mail.broadpark.no ([217.13.4.2]:6289 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S263805AbUDFN3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:29:52 -0400
Message-ID: <001001c41bdb$3ddbf6b0$1e00000a@black>
Reply-To: "Daniel Andersen" <daniel@majorstua.net>
From: "Daniel Andersen" <kernel-list@majorstua.net>
To: "Thomas Bach" <blox@tiscali.de>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <c4uag9$270t$1@ulysses.news.tiscali.de>
Subject: Re: Workaround for ReiserFS on root-filesystem
Date: Tue, 6 Apr 2004 15:29:51 +0200
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

> Hi Folks!
>
> I use ReiserFS for my root-filesystem while trying to upgrade to a newer
> kernel-version (still using 2.4.20) I got a error, that / could not be
> remounted read/write. After googling a bit I stumbled over the fact that
> ReiserFS as root-filesystem doesn't work since version 2.4.22 (or
> something like this).
>
> So I asked myself if there exists any workaround/howto/something-else so
>    I could get away from making my root-fs to an ext3 one. Does anyone
> know something about it?

Hmm.. It works perfectly fine for me with all 2.4.20-25 kernels, so you
should not trust everything you find on google ;-)
How big is your root partition? Which version of ReiserFS are you using?

