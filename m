Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUFVGnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUFVGnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 02:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUFVGnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 02:43:12 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:58265 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S261156AbUFVGnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 02:43:09 -0400
Date: Mon, 21 Jun 2004 21:51:59 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch]: Fix rivafb's NV_ARCH_
Message-ID: <20040621195158.GA12175@bogon.ms20.nix>
References: <20040601041604.GA2344@bogon.ms20.nix> <1086064086.1978.0.camel@gaston> <20040601135335.GA5406@bogon.ms20.nix> <20040616070326.GE28487@bogon.ms20.nix> <20040620192549.GA4307@bogon.ms20.nix> <1087791100.24157.9.camel@gaston> <20040621071159.GA7017@bogon.ms20.nix> <1087832204.22683.11.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1087832204.22683.11.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2004 at 10:36:44AM -0500, Benjamin Herrenschmidt wrote:
> Ok, well, it looks good to me. There is no active maintainer for rivafb
> so, I suppose if nobody complains of breakage, it should be fine.
It really shouldn't. PCIID's with 0x01X0 are NV10. There are others
which are NV40 but they aren't even recognized by rivafb yet.
Cheers,
 -- Guido

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1zxen88szT8+ZCYRAtQhAJ9DYSRVH2DYvomKslLQsJIxpvbEnACbB8O1
B7TFSyhw+UJxZVRdpe/7Yu0=
=eF85
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
