Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277998AbRJIVpx>; Tue, 9 Oct 2001 17:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277995AbRJIVpn>; Tue, 9 Oct 2001 17:45:43 -0400
Received: from jak-fw.mendelu.cz ([195.178.73.243]:62960 "EHLO v0jta.net")
	by vger.kernel.org with ESMTP id <S277993AbRJIVpY>;
	Tue, 9 Oct 2001 17:45:24 -0400
Date: Tue, 9 Oct 2001 23:45:08 +0200
From: Robert Vojta <vojta@pharocom.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Robert Vojta <vojta@pharocom.net>, seth goldberg <seth.goldberg@Sun.COM>,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: sis900 does not work in 2.4.10
Message-ID: <20011009234508.A2417@ipex.cz>
In-Reply-To: <Pine.LNX.3.96.1011009152114.22253A-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011009152114.22253A-100000@mandrakesoft.mandrakesoft.com>
User-Agent: Mutt/1.3.18i
X-Company: Pharocom, s.r.o.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> FWIW I just checked in this patch, which was going to go to Linus today
> or tomorrow, which contains updates for 630ET and ICS1893 PHY

Hi,
  when I try my SiS900 under 2.4.10-ac10 with or without Jeff's patch, it
works very well here in my laptop. But I have feelings that this kernel
(fastly configured 2.4.10-ac10 with Rik's eating patch) is little bit slower
than my previous one (2.4.6-ac2) ...

Best regards,
                                                            --Robert V0jta

--=20
    Robert Vojta <vojta at {pharocom.net - work | v0jta.net - private}>
          GPG: ID 1024D/A0CB7953            http://www.v0jta.net/=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvDb+QACgkQInNB3KDLeVOB1ACeLWufeQ5Zo5190x0PGt4sITDn
EysAn3vXDnpAW9AENS/sOA8xi5O4k73P
=vrN8
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
