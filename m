Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTKERaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTKERaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:30:08 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49352 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263007AbTKERaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:30:05 -0500
Date: Wed, 5 Nov 2003 18:29:07 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE disk information changed from 2.4 to 2.6
In-Reply-To: <20031105172310.GE5304@conectiva.com.br>
Message-ID: <Pine.SOL.4.30.0311051827330.7079-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Nov 2003, Flavio Bruno Leitner wrote:

> Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware

What are the exact kernel versions?

> changed. This behaviour is correct?

I am just investigating it.

> Using 2.4:
> hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)
>
> Using 2.6:
> hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)
>
> regards,
>
> --
> Flávio Bruno Leitner <fbl@conectiva.com.br>
> [ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]

