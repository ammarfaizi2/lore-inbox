Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130804AbQLHGhS>; Fri, 8 Dec 2000 01:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130998AbQLHGhJ>; Fri, 8 Dec 2000 01:37:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:53509 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130804AbQLHGgy>; Fri, 8 Dec 2000 01:36:54 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14896.31327.179696.632616@wire.cadcamlab.org>
Date: Fri, 8 Dec 2000 00:06:23 -0600 (CST)
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTFS repair tools
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org>
	<20001207221347.R6567@cadcamlab.org>
	<3A3066EC.3B657570@timpanogas.org>
	<20001208005337.A26577@alcove.wittsend.com>
	<20001207230407.S6567@cadcamlab.org>
	<3A306CE4.47B366B0@timpanogas.org>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Merkey]
> Please consider the attached patch to make it a little bit harder for
> folks to enable NTFS Write Support under Linux until it can get fixed
> properly.

Hey!  It was a joke!  A better way would be just to comment out the
CONFIG_NTFS_RW line entirely.  Actually, I think that *would* be a good
idea.  Anyone who has any business messing with NTFS_RW is more than
capable of editing Config.in.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
