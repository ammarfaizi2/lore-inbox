Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUAKFaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 00:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUAKFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 00:30:11 -0500
Received: from mail.intercable.net ([207.248.32.22]:59654 "EHLO
	macross.intercable.net") by vger.kernel.org with ESMTP
	id S265766AbUAKFaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 00:30:08 -0500
Message-ID: <4000DE12.7020100@intercable.net>
Date: Sat, 10 Jan 2004 23:24:34 -0600
From: "Pablo E. Limon Garcia Viesca" <plimon@intercable.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: GIVEUP [bootup kernel panic 2.6.x] no root partition detected?
References: <40005E9C.3030309@intercable.net> <4000D463.3040707@intercable.net> <200401110010.09341.gene.heskett@verizon.net>
In-Reply-To: <200401110010.09341.gene.heskett@verizon.net>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for your answer, I use LILO but that root is refering to
presisely the root partition, in my case it its /dev/hda5...
It is well configured in lilo, I can enter with kernel 2.4... but not
with 2.6...
if you want to know, the exact Kernel error at the begining is:

VFS: Cannot open root device "305" or hda5
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on hda5

but I know hda5 is the partition, maybe there has something to be with
the fact that the root partition is logical, in the extended partiton...
I mean is not a primary partition... could this be true???

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAN4SOGkG8a1Mf+oRAqD6AJ0UJi0lArcbh8SPk6b+z8jIdPULPwCgrTOE
IeWde/UI3AjoojonFRtB9AY=
=YXTH
-----END PGP SIGNATURE-----

