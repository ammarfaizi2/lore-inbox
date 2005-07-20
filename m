Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVGTE2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVGTE2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 00:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGTE2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 00:28:33 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:41450 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261615AbVGTE2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 00:28:31 -0400
Date: Wed, 20 Jul 2005 14:28:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Eric.Moore@lsil.com, olh@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus
 ion
Message-Id: <20050720142816.57a0364b.sfr@canb.auug.org.au>
In-Reply-To: <20050720031249.GA18042@humbolt.us.dell.com>
References: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com>
	<20050720031249.GA18042@humbolt.us.dell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__20_Jul_2005_14_28_16_+1000_Oluk/RIGAaOko.lh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__20_Jul_2005_14_28_16_+1000_Oluk/RIGAaOko.lh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Jul 2005 22:12:49 -0500 Matt Domsch <Matt_Domsch@dell.com> wrote:
>
> Sure it does, function names are defined symbols.
>=20
> I'm doing exactly this in my backport of the openipmi drivers to RHEL4
> and SLES9.

I missed the smiley, right :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Jul_2005_14_28_16_+1000_Oluk/RIGAaOko.lh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3dLkFdBgD/zoJvwRAoYYAJ420PoWmJK6Orx2oVPVwmjvpeVS3gCePGqB
A57tMnlQ2rWyt2ZwxICXAgg=
=qWmM
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Jul_2005_14_28_16_+1000_Oluk/RIGAaOko.lh--
