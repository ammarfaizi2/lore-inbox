Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUBSPvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 10:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUBSPvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 10:51:24 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59116 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267310AbUBSPvH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 10:51:07 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
Subject: Re: [PATCH] IDE update for 2.6.3 (1/9)
Date: Thu, 19 Feb 2004 16:57:20 +0100
User-Agent: KMail/1.5.3
References: <200402191556.38460.bzolnier@elka.pw.edu.pl> <00a901c3f6fc$79f819c0$0e25fe96@pysiak>
In-Reply-To: <00a901c3f6fc$79f819c0$0e25fe96@pysiak>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191657.20088.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 of February 2004 16:24, Maciej Soltysiak wrote:
> Hi,
>
> Bart, since you're doing IDE cleanups now, please take some time
> to update Documentation/ide.txt
>
> I tried to sync ide.txt with comments in ide.c & friends.

I remember, thanks for that.

Patch 2/9 - keep IDE parameters documentation in one place only
(Documentation/ide.txt).

> I remember also that Alan suggested removing some of the comments
> that actually were not true or the features did not exist or even cause
> serious problems.

"biostimings" - causing problems, removed in 2.6.0-test8
"slow", "flash" - did not exist, removed by this patch

> It would be nice to have it up2date while doing the cleanup.

Ok, there are still some comments to correct.

