Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSDJLfR>; Wed, 10 Apr 2002 07:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSDJLfP>; Wed, 10 Apr 2002 07:35:15 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:25861 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312590AbSDJLfM>; Wed, 10 Apr 2002 07:35:12 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv-driver broken in 2.5.8-pre
Date: 10 Apr 2002 09:40:16 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnab8240.p40.kraxel@bytesex.org>
In-Reply-To: <3CB40AF0.693C5130@delusion.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1018431616 25729 127.0.0.1 (10 Apr 2002 09:40:16 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  bttv-driver.c:2781: unknown field `kernel_ioctl' specified in initializer
>  
>  Gerd's latest patch v4l2-01-v4l2-api-2.5.8-pre2.diff doesn't fix it either.

Better try the patches named "fix-*" instead ...

  Gerd

-- 
#include </dev/tty>
