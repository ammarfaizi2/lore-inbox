Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUJRHAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUJRHAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 03:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUJRHAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 03:00:31 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58287 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261875AbUJRHA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 03:00:29 -0400
Date: Mon, 18 Oct 2004 17:00:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: rml@novell.com, v13@priest.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       bkonrath@redhat.com, greg@kroah.com
Subject: Re: [RFC][PATCH] inotify 0.14
Message-Id: <20041018170016.71d271d1.sfr@canb.auug.org.au>
In-Reply-To: <1098066043.16758.4.camel@vertex>
References: <1097808272.4009.0.camel@vertex>
	<200410180246.27654.v13@priest.com>
	<1098057129.5497.107.camel@localhost>
	<20041018112807.3a7edbf7.sfr@canb.auug.org.au>
	<1098066043.16758.4.camel@vertex>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__18_Oct_2004_17_00_16_+1000_v4FVeF/OsZ_OF//Z"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__18_Oct_2004_17_00_16_+1000_v4FVeF/OsZ_OF//Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi John,

On Sun, 17 Oct 2004 22:20:43 -0400 John McCutchan <ttb@tentacle.dhs.org> wrote:
>
> It is debatable whether or not the inotify patch should carry this
> dnotify config patch as well. I don't see it being that large of a
> burden on maintaining or using the patch that includes the dnotify
> config changes. 

You should probably submit the patch making dnotify optional as a
completely separate patch as it is logically s separate issue.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__18_Oct_2004_17_00_16_+1000_v4FVeF/OsZ_OF//Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBc2oE4CJfqux9a+8RAg8JAJ0epUFEQyrCDniohOG5h2Dd8IuMTQCdHG+0
Z35qIo03BW7Uu7zJgxEsFZI=
=6q/H
-----END PGP SIGNATURE-----

--Signature=_Mon__18_Oct_2004_17_00_16_+1000_v4FVeF/OsZ_OF//Z--
