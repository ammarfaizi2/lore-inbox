Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUACUqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbUACUqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:46:33 -0500
Received: from alhya.freenux.org ([213.41.137.38]:9344 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S263880AbUACUqb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:46:31 -0500
From: Mickael Marchand <marchand@kde.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] adaptec 1210sa
Date: Sat, 3 Jan 2004 21:46:18 +0100
User-Agent: KMail/1.5.94
References: <200312220305.29955.marchand@kde.org> <3FF21648.8030604@pobox.com>
In-Reply-To: <3FF21648.8030604@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Hugo Mills <hugo-lkml@carfax.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401032146.35175.marchand@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

this patch works fine on my box (with a soft raid1 array on top of it)

Cheers,
Mik

Le Wednesday 31 December 2003 01:20, vous avez écrit :
> Mickael Marchand wrote:
> > reading linux-scsi I found a suggestion by Justin to make adaptec's 1210
> > sa working. I made the corresponding patch for libata, and it actually
> > works :)
> >
> > it needs  some redesign to only apply to aar1210 (as standard sil3112
> > does not need it) and I guess some testing before inclusion.
>
> Here is the patch I'm applying.  Please test and let me know how it goes.
>
> Also, someone please send me a patch for the PCI ids :)
>
> 	Jeff
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9yoeyOYzc4nQ8j0RAlCkAJ9lr1ZIJqa5JTD/R7ELCvtP/Wn5WwCfQqzn
GEwV9zLRSQLpR8XY7Q4fzgk=
=w5Ft
-----END PGP SIGNATURE-----
