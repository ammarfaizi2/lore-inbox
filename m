Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbTLIUNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266087AbTLIUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:13:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2703 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266084AbTLIUNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:13:11 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mickael Marchand <marchand@kde.org>
Subject: Re: [PATCH] Silicon image 3114 SATA link (really basic support)
Date: Tue, 9 Dec 2003 21:14:47 +0100
User-Agent: KMail/1.5.4
References: <20031203204445.GA26987@gtf.org> <3FD612E2.90607@atl.lmco.com> <200312091954.28224.marchand@kde.org>
In-Reply-To: <200312091954.28224.marchand@kde.org>
Cc: Aron Rubin <arubin@atl.lmco.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092114.47241.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 09 of December 2003 19:54, Mickael Marchand wrote:

> the attached patch makes _both_ drivers work (whereas the previous one made
> only the libata one working)

Great!  Now I know it is really working.

I've already corrected your previous patch and included it in -bart1 patch:
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/ide-siimage-sil3114.patch

Yes, I forgot to send you corrected patch, sorry. :-)

--bart

