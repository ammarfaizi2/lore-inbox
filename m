Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTKAXyR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 18:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTKAXyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 18:54:17 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27312 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261262AbTKAXyQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 18:54:16 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: ratcheson@earthlink.net
Subject: Re: DMA unuseable on Compaq presario 1260
Date: Sun, 2 Nov 2003 00:59:18 +0100
User-Agent: KMail/1.5.4
References: <200311011726.23301.ratcheson@earthlink.net>
In-Reply-To: <200311011726.23301.ratcheson@earthlink.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311020059.18229.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you have OPTI621 IDE driver compiled-in?
[ Yes, I've just noticed it, help entry needs fixing. ]

On Sunday 02 of November 2003 00:26, Richard wrote:
> I have a Compaq laptop with the OPTI 82C825 IDE chipset.  Up until 2.4.20
> the DMA worked fine.  Beginning with 2.4.20 i get the message HDIO_SET_DMA
> FAILED: Operation not permitted each time I try to enable DMA.
>
> Distro is SuSE 9.0 current kenel is 2.4..21-99. default
>
> If I go back to 2.4.19 dma works fine.
>
> I have RTFM, maillists, etc. since April and all I can find are references
> to other systems with same problem and on in which Alan Cox says he changed
> something which broke the Toshiba.   But no fixes for my machine. I waited
> patiently for the 9.0 upgrade hoping it would be fixed but no joy.
>
> Is there an easy fix or do I need to compile a special kernel for this one?

