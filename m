Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264310AbRFNCbL>; Wed, 13 Jun 2001 22:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFNCbB>; Wed, 13 Jun 2001 22:31:01 -0400
Received: from server1.cosmoslink.net ([208.179.167.101]:29748 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S264310AbRFNCaw>; Wed, 13 Jun 2001 22:30:52 -0400
Message-ID: <016c01c0f47a$08807e40$4fa6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com>  <200106140200.f5E20NL3012987@typhaon.pacific.net.au>
Subject: Re: Download process for a "split kernel" (was: obsolete code must die) 
Date: Wed, 13 Jun 2001 19:30:52 -0700
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

>
> Or as a simpler design, something like;
>
>   * a copy of the kernel maintained in a CVS tree
>   * kernel download would pull down:
>         * the build script
>         * a file containing the list of filenames depended on by
>           each config option
>   * build script builds the config and then cvs updates the file list
>     and the files for each config option in question to the version as
>     tagged in the build script
>
> Someone could relatively easily maintain this separate to all the kernel
> developers, and it would mean only ever having to download files you were
> actually using.

OR

50 % of kernel size is from /linux/drivers
25 % of kernel size is from machine dependent /linux/arch/XXXX and
/linux/include/XXXX

If  we are able to divide Linux tree in such a way that everyone can
download it from from their personnal modems and enjoy linux.

may be i am wrong .

But i love downloading whole kernel and i usually refer different
architectures.

Thank you,

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.


