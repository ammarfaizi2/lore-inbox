Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131355AbRARBEq>; Wed, 17 Jan 2001 20:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRARBE1>; Wed, 17 Jan 2001 20:04:27 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:17682 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131355AbRARBEQ>; Wed, 17 Jan 2001 20:04:16 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14950.16631.2919.360911@wire.cadcamlab.org>
Date: Wed, 17 Jan 2001 19:03:50 -0600 (CST)
To: Mo McKinlay <mmckinlay@gnu.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <20010116182806.B6364@cadcamlab.org>
	<Pine.LNX.4.30.0101170035340.364-100000@nvws005.nv.london>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Mo McKinlay]
> We went through this last time around. What happens to directories
> with streams?

Yeah, I agree, 'file/stream' is lousy syntax as well.  If it weren't
for the possibility of having streams on directories, it would almost
be acceptible.  I still don't know which (':' or '/') is the worse
hack.

As I've said elsewhere in this thread, I can't think of *any* clean way
to shoehorn forks into nice, transparent posix calls.  It really wants
a new API.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
