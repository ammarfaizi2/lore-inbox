Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRHOVvH>; Wed, 15 Aug 2001 17:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbRHOVu5>; Wed, 15 Aug 2001 17:50:57 -0400
Received: from dsl081-080-099.lax1.dsl.speakeasy.net ([64.81.80.99]:42112 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S266982AbRHOVuu>; Wed, 15 Aug 2001 17:50:50 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: goemon@anime.net (Dan Hollis), maxwax@mindspring.com (Maxwell Spangler),
        oyhaare@online.no (=?iso-8859-1?q?=D8ystein?= Haare),
        linux-kernel@vger.kernel.org
Subject: Re: Via chipset
In-Reply-To: <E15X7Kc-0003xP-00@the-village.bc.nu>
X-NSA-Fodder: terrorist Clinton Project Monarch Mossad AK-47 Albania
From: "Bryan O'Sullivan" <bos@serpentine.com>
Date: 15 Aug 2001 14:50:55 -0700
In-Reply-To: <E15X7Kc-0003xP-00@the-village.bc.nu>
Message-ID: <87snetat6o.fsf@pelerin.serpentine.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a> Actually I've talked to a VIA person about it - the problem is I
a> don't have clean concrete repeatably way to generate the problem
a> and generate it rapidly.

Right.  The closest I've come to a reproducible setup is "keep the PCI
bus very busy and hope for the best".  This yields roughly 1 bad byte
read out of 150 million for stock 2.4.7, or 1 per 400 million for
2.4.8-ac3.

With error rates like this, it's not likely to be easy to find.

        <b
