Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131528AbQKJTtF>; Fri, 10 Nov 2000 14:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbQKJTs4>; Fri, 10 Nov 2000 14:48:56 -0500
Received: from rm05-24-167-191-55.ce.mediaone.net ([24.167.191.55]:48905 "EHLO
	calvin.localdomain") by vger.kernel.org with ESMTP
	id <S131528AbQKJTsr>; Fri, 10 Nov 2000 14:48:47 -0500
Date: Fri, 10 Nov 2000 13:46:39 -0600
From: Tim Walberg <tewalberg@mediaone.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, wmaton@ryouko.dgim.crc.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110134639.A30531@mediaone.net>
Reply-To: Tim Walberg <tewalberg@mediaone.net>
Mail-Followup-To: Tim Walberg <tewalberg@mediaone.net>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	"Jeff V. Merkey" <jmerkey@timpanogas.org>,
	wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
In-Reply-To: <jmerkey@timpanogas.org> <200011101930.eAAJUWi25886@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011101930.eAAJUWi25886@pincoya.inf.utfsm.cl> from Horst von Brand on 11/10/2000 13:30
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11/10/2000 16:30 -0300, Horst von Brand wrote:
>>	"Jeff V. Merkey" <jmerkey@timpanogas.org> said:
>>	> Horst von Brand wrote:
>>=09
>>	[...]
>>=09
>>	> > I've been using sendmail-8.11.1 (no encryption) to talk to MTAs all =
over
>>=09
>>	> Turn on encryption, and try sending attachements > 1MB and tell me if
>>	> you see any problems, like emails sitting in /var/spool/mqueue for a d=
ay
>>	> or two until they go out.  I can guarantee you will.
>>=09
>>	No encryption use; and the maximal message size is 1Mb (for sanity's sak=
e,
>>	after somebody sent a PowerPoint presentation (some 3Mb), then thought t=
hat
>>	perhaps the target didn't have PowerPoint, and sent it again with the
>>	PowerPoint package, then noticed this might not work either, and sent it
>>	_again_ with the full MS Office attached...  the joys of sysadminning ;-)
>>	--=20

Wow... that just might be one that's due for immortalizing
as an urban legend or what not... Definitely stupid user trick
material...


			tw


--=20
tewalberg@mediaone.net

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBOgxQncPlnI9tqyVmEQKFQACgnO2xn49O9W1MCtvLrf8m967jaP4AoP5s
2AhR9KL3wTvPQ62H3LKfpAVQ
=sLwb
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
