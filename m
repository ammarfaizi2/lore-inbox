Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTIVJEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTIVJEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 05:04:07 -0400
Received: from coruscant.franken.de ([193.174.159.226]:24557 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S262429AbTIVJEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 05:04:04 -0400
Date: Mon, 22 Sep 2003 10:53:26 +0200
From: Harald Welte <laforge@netfilter.org>
To: Diadon <diadon@isfera.ru>
Cc: David Miller <davem@redhat.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
Message-ID: <20030922085326.GF31401@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Diadon <diadon@isfera.ru>, David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	linux-kernel@vger.kernel.org
References: <20030921144013.GA22223@sunbeam.de.gnumonks.org> <3F6EAFF2.9080303@isfera.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <3F6EAFF2.9080303@isfera.ru>
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Setting Orange, the 46th day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
X-Spam-Score: -7.5 (-------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2003 at 12:16:50PM +0400, Diadon wrote:
> That patch is not work, after patching the kernel problem is not=20
> disappeared!
>=20
> Patch by Patrick is working fine and fix this problem

David, pleas defer applying that patch until further testing is done.

Sorry for the confusion.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/briGXaXGVTD0i/8RApMXAJ99Gyk0hjytb1waoRD7GIL3w3NzwgCfZs5e
z47nBbNVEDScmvY3zhetI/g=
=4WFX
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
