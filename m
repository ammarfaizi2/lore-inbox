Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDUNZh>; Sat, 21 Apr 2001 09:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132611AbRDUNZ2>; Sat, 21 Apr 2001 09:25:28 -0400
Received: from rm05-24-167-185-21.ce.mediaone.net ([24.167.185.21]:57269 "EHLO
	calvin.localdomain") by vger.kernel.org with ESMTP
	id <S132605AbRDUNZU>; Sat, 21 Apr 2001 09:25:20 -0400
Date: Sat, 21 Apr 2001 08:25:14 -0500
From: Tim Walberg <tewalberg@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: A question about MMX.
Message-ID: <20010421082514.H20020@mediaone.net>
Reply-To: Tim Walberg <tewalberg@mediaone.net>
Mail-Followup-To: Tim Walberg <tewalberg@mediaone.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104211353450.14048-100000@ns1.aniela.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JF+ytOk7PH04NsRm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104211353450.14048-100000@ns1.aniela.eu.org> from lk@aniela.eu.org on 04/21/2001 05:55
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JF+ytOk7PH04NsRm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

MMX **is** potentially used in the md (RAID-5) code for parity
calculation, IIRC, though. That's about the only place that I
can think of that it's used, but I don't claim to know the
inner workings of the entire kernel, either...

			tw


On 04/21/2001 13:55 +0300, lk@aniela.eu.org wrote:
>>=09
>>	I have a Intel Pentium MMX machine and it acts as a mailserver, webserve=
r,
>>	ftp and I use X on it. I would like to know if the MMX instructions are
>>	used by the kernel in this operations or not (networking, X etc.).
>>=09
>>=09
>>	Thank you,
>>=09
>>	/me
>>=09
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
+--------------------------+------------------------------+
| Tim Walberg              | tewalberg@mediaone.net       |
| 828 Marshall Ct.         | www.concentric.net/~twalberg |
| Palatine, IL 60074       |                              |
+--------------------------+------------------------------+

--JF+ytOk7PH04NsRm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBOuGKOcPlnI9tqyVmEQJ1iACgrVO5FaEAhddjfR/4FsS0YIX6OqoAoIH5
Afsq3JkSF8UpQNz3wlalWQmN
=k/nT
-----END PGP SIGNATURE-----

--JF+ytOk7PH04NsRm--
