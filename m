Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268737AbUI3FCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268737AbUI3FCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268733AbUI3FCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:02:23 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:65508 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S268717AbUI3FCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:02:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 01:02:07 -0400
User-Agent: KMail/1.7
Cc: "Markus T." <markus@trippelsdorf.net>
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org> <pan.2004.09.30.04.53.05.120184@trippelsdorf.net>
In-Reply-To: <pan.2004.09.30.04.53.05.120184@trippelsdorf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409300102.07373.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.8.60] at Thu, 30 Sep 2004 00:02:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 September 2004 00:53, Markus T. wrote:
># bzcat patch-2.6.9-rc3.bz2 | patch -p1
>...
>patching file fs/nfs/file.c
>Hunk #2 FAILED at 74.
>Hunk #3 FAILED at 91.
>2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej
>...
>
>___
>Markus
>
And thats one of the reasons I never dl the bz2 version.

You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
I just checked my scrollback and there is no such error here.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
