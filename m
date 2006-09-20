Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWITPxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWITPxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWITPxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:53:34 -0400
Received: from natgw.netstream.ch ([62.65.128.28]:42691 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751680AbWITPxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:53:33 -0400
Date: Wed, 20 Sep 2006 17:53:28 +0200
From: Nico Schottelius <nico-kernel20060920@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Nico Schottelius <nico-kernel20060920@schottelius.org>
Subject: Block information: Changing from GB to GiB
Message-ID: <20060920155328.GB3432@schottelius.org>
Reply-To: LKML <linux-kernel@vger.kernel.org>,
       nico-kernel20060920@schottelius.org
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	nico-kernel20060920@schottelius.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.17.13-hydrogenium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Would you accept patches, which
   a) add printing MiB, GiB, ... ADDITIONALy to MB, GB, ..
   b) replace GB with GiB
?

If so, I would check the kernel source for occurences of those
units and replace the calculation.

Imho, it would be nicer to print GiB only, because it's the more
accurate unit (today).

You can have a look at GiB and co. at wikipedia, if you are not familar
with it: http://en.wikipedia.org/wiki/Gigabyte

Sincerly

Nico

P.S.: Please CC me on reply.


--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUBRRFj+LOTBMvCUbrlAQLPGQ//UleNa/hKgOlKLZjbJ6E9KhFhqW1xVVPX
aSk0J5ac2CimU7PsBKiN60Pg1LJ1PjSjVvye8gvi2KNfvRt345z1lzhilMRAEmT2
BYsrx7AEQptZPrSsnbEo2ej3OldEIa+UshcMg0mL05C1y+A5g0lQgUt6RiNuHeFD
VTnWR7YdEimy1WrxPwFOsybe3yfKvT2rgEQ+wFDS3lsvVls7ypOs1os79sL1pWHi
gcYd2iPVhJdd7NJ2Do9D/mC+QPRLidhk4XFSJ8umdusrghuCjBc9kzsmy3L7Cmsj
oEZAPRlku4DA969tBJdxgJkpDWD7xl1mWeJmoD8zqYhCf3DNmwBiRVdqLQdDjE+y
V2Fp/vV24v7MAcU+ckpAp3QGhyGeYVm5xQKvLBW1JWSVTMihThEA2Mh/ZsdfteDy
HXwVi66RgLvb0NpCK8rZbyL3/q9pu3OclGaMe52OpIJaKLX+c1nwYTyPDdal5mf3
s6afKQhIEq5aHjBfjk8V0UytWXDyNhL/weeWjlv1kJhdBUAeduZo+O28Mtrvx77K
0VrrWMVTmQqWUSglkK5PEacCGoxeGiKLmAw8MxZIm/Nvd93U94QExDU0iellZhr/
DFguZDfXx6/Y5cPKZtIfZ6U7YKsaSwzxj9n0s/b6Z7ll24LH0iTzfCLDV3drKZyr
+B6cEXNQa+k=
=C4pk
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
