Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131277AbQKADxi>; Tue, 31 Oct 2000 22:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbQKADx3>; Tue, 31 Oct 2000 22:53:29 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:61712
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S131254AbQKADxU>;
	Tue, 31 Oct 2000 22:53:20 -0500
Date: Tue, 31 Oct 2000 19:53:16 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001031195316.A1233@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com> <E13qiR9-0008FT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13qiR9-0008FT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 31, 2000 at 08:55:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 31, 2000 at 08:55:13PM +0000, Alan Cox wrote:
> 	Does autofs4 work yet

Autofs4 was fixed in 2.4.0-test10-pre6 or so.  Autofs4 for 2.2.x has
been working for some time, though I just updated the 2.2 patch so it
doesn't stomp on autofs (v3).

	J

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjn/k6wACgkQf6p1nWJ6IgKYEwCfZRZIbG1XkZHX3VpsWDAL3VXK
OUcAn2RV6ueg6PsjtkMDlluanExfRLBM
=v/tU
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
