Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSEFMiX>; Mon, 6 May 2002 08:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSEFMiW>; Mon, 6 May 2002 08:38:22 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31578 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314409AbSEFMiU>; Mon, 6 May 2002 08:38:20 -0400
Date: Mon, 6 May 2002 13:38:09 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add NetMos 9835 to parport_serial
Message-ID: <20020506133809.G27042@redhat.com>
In-Reply-To: <20020506095735.Y27042@redhat.com> <Pine.LNX.4.44.0205061359570.12156-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="p3t3jlvjhqjzPvuq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p3t3jlvjhqjzPvuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2002 at 02:14:25PM +0200, Zwane Mwaikambo wrote:

> All the patches i've seen thus far were for some other chip (forgot the=
=20
> ID), but for that 9835 i needed it desperately so i tested it quite a lot=
.=20
>=20
> +	/* netmos_9835 (not tested) */	{ 1, { { 2, -1 }, } },
>=20
> I'm not sure about the others, but i doubt that one would work.

Well, if { 2, 3 } works then { 2, -1 } will surely work, although
without ECP support.  I didn't realise that NetMos cards had ECP
support at the time I wrote the above code.

> Where there conflicting success/failure reports for the same
> devices?

I'm sorry, I don't recall.

Tim.
*/

--p3t3jlvjhqjzPvuq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81nkxyaXy9qA00+cRAiwpAKCy+P8mLfZYQohquqUWtaDivZeruQCdHr5M
HG5a72ejfQbONdoVeDnCa+w=
=z7Ip
-----END PGP SIGNATURE-----

--p3t3jlvjhqjzPvuq--
