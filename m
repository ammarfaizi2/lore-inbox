Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbREYBvo>; Thu, 24 May 2001 21:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263484AbREYBve>; Thu, 24 May 2001 21:51:34 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:11601 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S263483AbREYBvT>; Thu, 24 May 2001 21:51:19 -0400
Message-ID: <00d001c0e4bd$2e04eb00$57a6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <l03130306b7332a134958@[209.239.217.188]> <9ekb78$u2a$1@cesium.transmeta.com>
Subject: Re: Ramdisk Initialization Problem
Date: Thu, 24 May 2001 18:51:12 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote :
>
> First of all, try the latest kernel if you are going to report a bug.
>

As far as i know , Regarding Ramdisk linux-2.4.4 and 2.4.1 are similar.
, no body fixed this problem after 2.4.1 , If somebody please let me know .

Anyhow i will try with latest kernel and let you know , but it will take
some time .

> For the kernel people, this is classic evidence of relying on
> uninitialized memory; the "few minutes" is roughly how long it takes
> modern SDRAM to *reliably* discharge.
>

In my case , If i restart after 5 minutes it works fine , but if i restart
after 1 or 2 minutes kernel hangs during uncompressing ramdisk.

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.

> -hpa


