Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262630AbRE3GPY>; Wed, 30 May 2001 02:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbRE3GPP>; Wed, 30 May 2001 02:15:15 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:50427 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262630AbRE3GPE>; Wed, 30 May 2001 02:15:04 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105300614.f4U6EtRg021226@webber.adilger.int>
Subject: Re: [PATCH] compiler warning fixes in 8139too.c
In-Reply-To: <Pine.LNX.4.21.0105300102280.424-100000@presario>
 "from Anuradha Ratnaweera at May 30, 2001 01:06:25 am"
To: Anuradha Ratnaweera <anuradha@gnu.org>
Date: Wed, 30 May 2001 00:14:55 -0600 (MDT)
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anuradha writes:
> The following patch fixes some warnings when 8139 driver is compiled
> without 8129 support.

I've already submitted an improved patch to Jeff Garzik (8139too
maintainer) that fixes this issue and he will include along with other
fixes to the driver when he updates it next.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
