Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUBCTks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbUBCTh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:37:26 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:53247 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266139AbUBCThB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 14:37:01 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Davin McCall <davmac@ozonline.com.au>
Subject: Re: [PATCH] various IDE patches/cleanups
Date: Tue, 3 Feb 2004 20:41:09 +0100
User-Agent: KMail/1.5.3
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au> <200401061213.39843.bzolnier@elka.pw.edu.pl> <20040130142725.1a408f9e.davmac@ozonline.com.au>
In-Reply-To: <20040130142725.1a408f9e.davmac@ozonline.com.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402032041.09696.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Friday 30 of January 2004 04:27, you wrote:
> I've been doing some hacking on the IDE layer, just to fix a few issues I
> noticed going through the code. Due to the complex nature of the code I'm
> bound to have missed some things and perhaps misunderstood others.
> Nevertheless I'm posting these patches in the hope that they can be tested
> on other machines, rejected, or even accepted.
>
> Comments and criticisms are welcome.

Thanks!  I'm slowly reading through them (yeah, code is really complex).
Patch 3rd and 5th seems okay, 2nd and 4th need some more checking/thinking.

> The first patch, below, is already included in the -mm tree. The further
> patches are appearing here for the first time.

It was pushed to Linus and merged.

--bart

