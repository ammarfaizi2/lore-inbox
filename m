Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQKAHmn>; Wed, 1 Nov 2000 02:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbQKAHmd>; Wed, 1 Nov 2000 02:42:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:57099 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129026AbQKAHmU>; Wed, 1 Nov 2000 02:42:20 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14847.51541.625121.78324@wire.cadcamlab.org>
Date: Wed, 1 Nov 2000 01:42:13 -0600 (CST)
To: Vladislav Malyshkin <mal@gromco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FEF039.69FAFDB2@gromco.com>
	<14846.63285.212616.574188@wire.cadcamlab.org>
	<39FF0A71.FE05FAEB@gromco.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Vladislav Malyshkin <mal@gromco.com>]
> Also, the function remove_duplicates can be written using make rules
> and functions.  Using functions "foreach" "if" from make and
> comparison you can easily build a function remove_duplicates in make,
> no shell involved.

Could you please write me this function?  I am curious to see how you
do it.

I am also a bit skeptical.  About 3 months ago, I thought it would be
possible to do this, so I spent a few hours fiddling around and reading
documentation.  I failed; nothing I tried worked.

> so instead of $(sort) your will have $(remove_duplicates) written
> entirely in make.

That would make me happy.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
