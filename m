Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262651AbSJGTp3>; Mon, 7 Oct 2002 15:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262652AbSJGTp3>; Mon, 7 Oct 2002 15:45:29 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:10804 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S262651AbSJGTp1>;
	Mon, 7 Oct 2002 15:45:27 -0400
From: <Hell.Surfers@cwctv.net>
To: jhf@rivenstone.net, swdlinunx@earthlink.net, linux-kernel@vger.kernel.org
Date: Mon, 7 Oct 2002 20:50:34 +0100
Subject: RE: PC speaker dead in 2.5.40?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034020234408"
Message-ID: <003ab16491907a2DTVMAIL10@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034020234408
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

whats the technical reason.

Cheers, Dean.

On 	Mon, 7 Oct 2002 03:08:57 -0400 	jhf@rivenstone.net (Joseph Fannin) wrote:

--1034020234408
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Mon, 7 Oct 2002 20:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262544AbSJGSwL>; Mon, 7 Oct 2002 14:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbSJGSvx>; Mon, 7 Oct 2002 14:51:53 -0400
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:48770 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id <S262548AbSJGSvS>; Mon, 7 Oct 2002 14:51:18 -0400
Received: by caphernaum.rivenstone.net (Postfix, from userid 1000)
	id 5EDEE37965; Mon,  7 Oct 2002 03:08:57 -0400 (EDT)
Date: Mon, 7 Oct 2002 03:08:57 -0400
To: Steve Dover <swdlinunx@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker dead in 2.5.40?
Message-ID: <20021007070857.GA1927@rivenstone.net>
Mail-Followup-To: Steve Dover <swdlinunx@earthlink.net>,
	linux-kernel@vger.kernel.org
References: <3DA1BD31.4040707@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <3DA1BD31.4040707@earthlink.net>
User-Agent: Mutt/1.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2002 at 11:58:25AM -0500, Steve Dover wrote:
> Configuring a kernel with Sound support with either
> OSS or ALSA, I still get nothing from my PC speaker.
> Works fine under 2.4.18.

    Look under all the submenus in the Input section of
    "menuconfig" for the speaker entry and enable it.

    There's a good technical reason why the speaker is an input
    device, but hiding it in the menus is *bad*.

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Joseph Fannin
jhf@rivenstone.net

"Anyone who quotes me in their sig is an idiot." -- Rusty Russell.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9oTMJWv4KsgKfSVgRAmMFAJ0eRR8PR+l8NGWQZkyo/Rs/duDrGQCeO959
3guOAe0wW5jyTwmGSeEXZ2g=
=4x3B
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034020234408--


