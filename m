Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUITP0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUITP0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUITP0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:26:43 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:16348 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S266687AbUITP0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:26:40 -0400
Date: Mon, 20 Sep 2004 17:24:58 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920152458.GB2791@thundrix.ch>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <20040920105950.GI5482@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20040920105950.GI5482@DervishD>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Sep 20, 2004 at 12:59:50PM +0200, DervishD wrote:
>     Bad idea... ;))) I upgraded my 'mount' yesterday. I was using a
> mount from Debian, from 1998 more or less, that worked flawlessly
> except for the '--bind' feature and things like those. I used
> /etc/mtab as a symlink to /proc/mounts, and all worked OK except for
> the double root entry and the need to manually call losetup to delete
> unused /dev/loop entries.

I  keep a  mvmount and  bindmount program  on my  farm for  that exact
purpose. :)

			   Tonnerre

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBTvZJ/4bL7ovhw40RAvlCAJ4vQiIr8eKJ+zKX34fwsRvt/FRAFwCgoFPB
+QJGtnO08fQC5OC4vX7tQBI=
=LRvf
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
