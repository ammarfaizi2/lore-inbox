Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSCUC57>; Wed, 20 Mar 2002 21:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293217AbSCUC5t>; Wed, 20 Mar 2002 21:57:49 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:29437 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S293206AbSCUC5h>; Wed, 20 Mar 2002 21:57:37 -0500
Message-ID: <006101c1d084$275029b0$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu>
Subject: Re: Linux 2.4.19pre3-ac4
Date: Wed, 20 Mar 2002 21:57:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 21 Mar 2002 02:57:35.0651 (UTC) FILETIME=[274A0F30:01C1D084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Linux 2.4.19pre3-ac4

<snip>

> o The incredible shrinking kernel patch (Andrew Morton)

Is there a magic incantation I need in order to see an improvement from this?
I'm observing a slight (< 10 KB) increase from -ac3 to -ac4. Same .config, same
compiler.

I only build 2 modules; everything else is static. Perhaps Andrew's fix is for
heavy module users?

--Adam


