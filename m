Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTK1X5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTK1X5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:57:30 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9922 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263587AbTK1X52
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:57:28 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Eduard Hasenleithner <ehasenle@spamcop.net>
Subject: Re: Better performance with pdc20376 compared to SiI 3112
Date: Sat, 29 Nov 2003 00:58:42 +0100
User-Agent: KMail/1.5.4
References: <3FC7DEB3.7030104@spamcop.net>
In-Reply-To: <3FC7DEB3.7030104@spamcop.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311290058.42959.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 of November 2003 00:48, Eduard Hasenleithner wrote:
> Hello.
>
> Although I like the SiI 3112 due it's open specs I found that the

There are no open specs for SiI3112, "datasheet" from SiI page is useless.

--bart

> somehow "closed" pdc20376 promise chip performs essentially better
> with the new GPL drivers on a non-tweaked 2.6.0-test11 kernel :(
> With SiI 3112 I get about 16MB/s, with pdc20376 54MB/s, which is
> most likely the maximum harddisk performance of my seagate drive.
>
> So what is the status of the siimage driver? Can I expect it to
> improve in further kernel releases?
>
> On a further note I found that no /proc/ide nodes are allocated
> for the siimage driver. What can be the reason for this?
>
> Below this section I show output from dd and hdparm in order
> to give information about my setup.

<...>

