Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRBSU2E>; Mon, 19 Feb 2001 15:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbRBSU1y>; Mon, 19 Feb 2001 15:27:54 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:25105 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129421AbRBSU1m>; Mon, 19 Feb 2001 15:27:42 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14993.33186.622147.313411@wire.cadcamlab.org>
Date: Mon, 19 Feb 2001 14:27:14 -0600 (CST)
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans 
In-Reply-To: <20010217180547.B28785@cadcamlab.org>
	<200102181714.f1IHE8O94912@aslan.scsiguy.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Justin Gibbs]
> I've verified the driver's functionality on 25 different cards thus
> far covering the full range of chips from aic7770->aic7899.

That's very good to hear.  I know the temptation of only testing on new
hardware; that's why I was concerned.

> Lots of people here at Adaptec look at me funny when I pull a PC from
> the scrap-heap, or pull an old, discontinued card from an unused
> marketing display for use in my lab

Heh. (:

BTW, is there really enough common ground between the whole series of
AIC chips to justify a single huge driver?  I know they ship three
separate NT drivers to cover this range..

Peter
